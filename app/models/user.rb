class User < ActiveRecord::Base
  after_destroy :ensure_an_admin_remains
  validates :name, presence: true, uniqueness: true
  has_secure_password
  
  private
  
  def ensure_an_admin_remains
    if User.count.zero?
      raise "Can't delete the last user"
    end
  end
end
