require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  fixtures :products
  
  setup do
    @product = products(:ruby)
    @cart = Cart.new
    @item = LineItem.new(product: @product, cart: @cart)
  end
  
  test "should calculate its price" do
    assert_equal @item.total_price, @product.price
  end
  
  test "should calculate its price when quantity is > 1" do
    @item.quantity = 10
    assert_equal @item.total_price, @product.price * 10
  end
  
  test "should be free with quantity == 0" do
    @item.quantity = 0
    assert_equal @item.total_price, 0
  end
  
  test "should have the product's title" do
    assert_equal @item.title, @product.title
  end
  
end
