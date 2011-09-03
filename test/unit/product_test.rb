require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = Product.new(title: "My Book Title",
                          description: "yyy",
                          image_url: "zzz.jpg",
                          price: 19.95)
  end
  
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end
  
  test "product price must be positive" do
    @product.price = -1
    assert @product.invalid?
    assert_equal "must be greater than or equal to 0.01",
                 @product.errors[:price].join('; ')
  end
  
  test "product price must be greater than 0" do
    @product.price = 0
    assert @product.invalid?
    assert_equal "must be greater than or equal to 0.01",
                 @product.errors[:price].join('; ')
  end
  
  test "product is valid when > 0.01" do
    @product.price = 0.01
    assert @product.valid?
  end
  
  test "image_url cannot be invalid" do
    bad = %w{fred.doc fred.gif/more fred.gif.more}
    bad.each do |url|
      @product.image_url = url
      assert @product.invalid?, "#{url} shouldn't be valid"
    end
  end
  
  test "image_url must be valid" do
    bad = %w{fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif}
    bad.each do |url|
      @product.image_url = url
      assert @product.valid?, "#{url} should be valid"
    end
  end
end
