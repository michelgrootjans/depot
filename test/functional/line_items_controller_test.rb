require 'test_helper'

class LineItemsControllerTest < ActionController::TestCase
  setup do
    @product = products(:ruby)
    @cart = Cart.new
    @item = LineItem.new(product: @product, cart: @cart)
    @item.save
  end

  test "should create line_item" do
    assert_difference('LineItem.count') do
      post :create, product_id: products(:ruby).id
    end

    assert_redirected_to store_path
  end
  
  test "should create line_item via ajax" do
    assert_difference('LineItem.count') do
      xhr :post, :create, product_id: products(:ruby).id
    end
    assert_response :success
    assert_select_jquery :html, '#cart' do
      assert_select 'tr#current_item td', /Programming Ruby 1.9/
    end
  end

  test "destroy should delete item when quantity is 1" do
    assert_difference('LineItem.count', -1) do
      delete :destroy, id: @item.to_param
    end
  end

  test "destroy should decrement quantity when quantity is 2" do
    @item.quantity = 2
    @item.save
    delete :destroy, id: @item.to_param
    @item.reload
    assert_equal 1, @item.quantity
  end

  test "destroy should redirect to store" do
    delete :destroy, id: @item.to_param
    assert_redirected_to store_path
  end

  
  test "destroy should destroy line_item via ajax" do
    assert_difference('LineItem.count', -1) do
      xhr :post, :destroy, id: @item.id
    end
    assert_response :success
  end
end
