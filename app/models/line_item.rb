class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  belongs_to :cart
  
  def total_price
    product.price * quantity
  end
  
  def title
    product.title
  end
end