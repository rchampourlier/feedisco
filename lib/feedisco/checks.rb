module Feedisco::Checks

  # Check if the specified URL is a feed URL. The check is performed by opening the
  # URL and checking the content type. If it matches a content type within
  # Feedisco.feed_content_types, the URL is considered as a feed and the method returns
  # true.
  def feed?(url)
    feed_content_type?(url)
  end

  private
  
  # Determines if the specified URL looks like a feed. We consider it does if:
  #   - it ends with a 'feed-suffix': .rdf, .xml, .rss
  #   - it contains a 'feed=rss' or 'feed=atom' query param (well, we don't check
  #     if it is really a query param, as long as it is in the URL)
  #   - it ends with 'atom' or 'feed' (with or without the '/' at the end)
  def looks_like_feed?(url)
    (url =~ %r{(\.(rdf|xml|rss)$|feed=(rss|atom)(&(.)+)?$|(atom|feed)/?$)}i) != nil
  end
  
  # Open the specified URL and check its content type. Returns true if the content type
  # is a feed content type (in Feedisco.feed_content_types)
  # 
  # You can pass an URL (a string) or a file (open(...), a Tempfile instance) to the method.
  def feed_content_type?(url_or_file)    
    opened = false

    if url_or_file.is_a? String
      harmonized_url = harmonize_url(url_or_file)
      file = open(harmonized_url)
      opened = true
    
    elsif url_or_file.class.to_s == 'Tempfile'
      file = url_or_file
    
    else raise ArgumentError.new('argument must be a String (url) or a Tempfile created with `open(url)`')
    end

    # Retrieve page content type
    content_type = file.content_type.downcase
    if content_type == "application/octet-stream"
      content_type = file.meta["content-type"].gsub(/;.*$/, '')
    end
    file.close if opened

    # Check if the content-type indicates RSS/Atom feed (in Feedisco.feed_content_types)
    Feedisco.feed_content_types.include?(content_type)
  end
end