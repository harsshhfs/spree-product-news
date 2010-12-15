module SimpleBlogExtension
  class Engine < Rails::Engine
    
    def self.activate

      Spree::BaseController.class_eval do
        helper ArticlesHelper
      end

      AppConfiguration.class_eval do
        preference :disqus_id, :default => nil
        preference :news_feed_url, :default => '/news.xml'
      end

    end


    config.autoload_paths += %W(#{config.root}/lib)
    config.to_prepare &method(:activate).to_proc

  end
end
