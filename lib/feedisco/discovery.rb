require 'feedisco/utilities'
require 'feedisco/checks'

module Feedisco
  extend Checks
  extend Utilities

  module Discovery
    
    # Find RSS/Atom feed URLs by looking around the specified URL.
    def find(url, args = {})
      raise ArgumentError.new("url can't be nil!") if url.nil?
      
      harmonized_url = harmonize_url(url)

      raise ArgumentError.new("url's protocol must be 'http(s)' or 'feed' (#{url})") if harmonized_url.nil?

      feeds = []

      # Open the URL to check the content-type or crawl for feed links
      open(harmonized_url) do |file|

        if feed_content_type?(file)
          # Add the url to feeds if it shows a feed content type
          feeds << harmonized_url
        
        else
          # Else, parse the page to search for links
          doc = Nokogiri::HTML(file.read)

          # Check <link> elements
          doc.css('link').each do |link|
            discovery = complete_extracted_url(link[:href], harmonized_url) if link[:rel] =~ %r{(alternate|service.feed)}i && Feedisco.feed_content_types.include?(link[:type].downcase.strip)
            feeds << discovery unless discovery.nil? or feeds.include? discovery
          end

          # Check <a> elements
          doc.css('a').each do |a|
            if looks_like_feed? a[:href] and
               (a[:href] =~ %r{\A/} or a[:href] =~ %r{#{URI.parse(harmonized_url).host}/})

              discovery = complete_extracted_url(a[:href], harmonized_url)
              feeds << discovery unless discovery.nil? or feeds.include?(discovery)
            end
          end

          # Check <a> elements again, less restrictively, so we add all discovered feeds even the ones
          # on external domains, but the will come after in the feeds array.
          doc.css('a').each do |a|
            discovery = complete_extracted_url(a[:href], harmonized_url) if looks_like_feed? a[:href]
            feeds << discovery unless discovery.nil? or feeds.include?(discovery)
          end
        end
      end

      feeds
    end
  end
end