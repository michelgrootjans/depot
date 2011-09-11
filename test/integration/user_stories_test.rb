require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products

  test "A user goes to the store and buys a product" do
    LineItem.delete_all
    Order.delete_all

    ruby_book = products(:ruby)
    
    go_to_store
    add_to_cart ruby_book
    
    assert_equal 1, cart.size
    assert_equal ruby_book, cart.line_items[0].product
    assert_equal 1, cart.line_items[0].quantity
    
    go_to_checkout
    place order: {
        name: "Dave Thomas",
        address: "123 the street",
        email: "dave@example.com",
        pay_type: "Check"
    }
    
    assert_equal 0, cart.line_items.size
      
    orders = Order.all
    assert_equal 1, orders.size
    
    order = orders[0]
    assert_equal "Dave Thomas", order.name
    assert_equal "123 the street", order.address
    assert_equal "dave@example.com", order.email
    assert_equal "Check", order.pay_type
    
    assert_equal 1, order.size
    line_item = order.line_items[0]
    assert_equal ruby_book, line_item.product
    assert_equal 1, line_item.quantity
    
    mail = ActionMailer::Base.deliveries.last
    assert_equal ["dave@example.com"], mail.to
    assert_equal 'Sam Ruby <depot@example.com>', mail[:from].value
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
  end

  def go_to_store
    get "/"
    assert_response :success
    assert_template "index"
  end
  
  def add_to_cart product
    xml_http_request :post, '/line_items', product_id: product.id
    assert_response :success
  end
  
  def go_to_checkout
    get "/orders/new"
    assert_response :success
    assert_template :new
  end

  def place order
    post_via_redirect "/orders", order
    assert_response :success
    assert_template :index
  end
  
  def cart
    Cart.find(session[:cart_id])
  end
end
