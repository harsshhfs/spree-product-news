
Spree::Admin::OrdersController.class_eval do
  after_filter :set_admin , :only => [:update]
  
  def set_admin
    @order.admin = current_user
    @order.save
  end
end
