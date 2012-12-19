module SpreeProductNews
  class Engine < Rails::Engine
    
    def self.activate

      Spree::BaseController.class_eval do
        helper ArticlesHelper
      end

      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*decorator.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
      Dir.glob(File.join(File.dirname(__FILE__), '../../../app/overrides/*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
      Deface::Override.new(:virtual_path => "spree/admin/orders/show",
                           :name => "converted_admin_order_show_addresses_971422162",
                           :insert_before => "[data-hook='admin_order_show_addresses'], #admin_order_show_addresses[data-hook]",
                           :partial => "spree/admin/orders/admin_name",
                           :disabled => false)
                           
    end


    config.autoload_paths += %W(#{config.root}/lib)
    config.to_prepare &method(:activate).to_proc

  end
end
