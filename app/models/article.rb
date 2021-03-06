class Article < FileModel
  attr_accessor :slug
  
  def initialize(file, key, meta, body)
    super(file, key, meta, body)
    @slug = key.split("-").last
  end
  
  def self.tagged(tag) 
    tag_index[tag.strip].to_a.map do |key|
      Article.find(key)
    end
  end

  def self.archive_years
    @@archive_years ||= files.map{|f| File.basename(f).split('-')[0] }.uniq
  end

  # Store list of articles for each tag in a hash
  # Fast enough for the small number of articles we're dealing with
  @@tag_index = {}
  def self.tag_index
    return @@tag_index if @@tag_index.present?
    all.each do |a| 
     a.tags.split(',').map(&:strip).each do |t| 
       @@tag_index[t] ||= []
       @@tag_index[t] = (@@tag_index[t] << a.key).uniq
      end
    end
    @@tag_index
  end
  
  %w(title_tag meta_keywords meta_description product_name image).each do |attribute|
    define_method(attribute) do
      meta[attribute]
    end
  end

end