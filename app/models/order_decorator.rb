Spree::Order.class_eval do
  belongs_to :admin , :class_name => "User" , :foreign_key => "admin_id"
end

Spree::User.class_eval do
  has_many :orders_created , :class_name => "Order" , :foreign_key => "admin_id"
end
