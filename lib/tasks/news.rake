def ask message
  print message
  STDIN.gets.chomp
end

namespace :spree_product_news do
  
  desc "Create a new news article with basic file structure and naming"
  task :new => :environment do
  
    title = ask('Title: ')
    slug = title.empty?? nil : title.strip.parameterize.to_s

    article = {'slug' => slug, 'title' => title, 'tags' => '', 'date' => Date.today}.to_yaml
    article << "\n"
    article << "Lorem ipsum dolor sit amet...\n\n"

    path = "#{RAILS_ROOT}/content/article/#{Time.now.strftime("%Y-%m-%d")}#{'-' + slug if slug}.txt"

    unless File.exist? path
      File.open(path, "w") do |file|
        file.write article
      end
      puts "an article was created for you at #{path}."
    else
      puts "I can't create the article, #{path} already exists."
    end  
    
  end
  
end

