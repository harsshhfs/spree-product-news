module ProductNewsExtension
  class Engine < Rails::Engine
    
    def self.activate

      Spree::BaseController.class_eval do
        helper ArticlesHelper
      end

      Spree::AppConfiguration.class_eval do
        preference :news_feed_url, :default => '/news.xml'
      end

      Deface::Override.new(:virtual_path => "admin/orders/show",
                           :name => "converted_admin_order_show_addresses_971422162",
                           :insert_before => "[data-hook='admin_order_show_addresses'], #admin_order_show_addresses[data-hook]",
                           :partial => "admin/orders/admin_name",
                           :disabled => false)
                           
    end


    config.autoload_paths += %W(#{config.root}/lib)
    config.to_prepare &method(:activate).to_proc

  end
end
