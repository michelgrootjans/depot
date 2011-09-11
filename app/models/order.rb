class Order < ActiveRecord::Base
  PAYMENT_TYPES = ["Check", "Credit Card", "Purchase Order"]
  
  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES
  
  has_many :line_items, dependent: :destroy
  
  def add_line_items_from cart
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
  
  def size
    line_items.size
  end
end