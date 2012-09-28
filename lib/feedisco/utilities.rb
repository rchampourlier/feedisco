module Feedisco::Utilities

  # Check the specified URL protocol. To be considered as a valid feed URL, it must
  # match either 'feed', 'http', or 'https', or be nil. If it does, the url is returned
  # with 'http' or 'https' protocol (replacing nil and 'feed' ones). Else, it returns nil.
  def harmonize_url(url)
    url_uri = URI.parse(url)

    case url_uri.scheme
    when nil
      "http://#{url}"

    when 'feed'
      url.sub(%r{feed://}, 'http://')
    
    when %r{http(s)?}
      url

    else
      nil
    end
  end

  # Complete extracted_url with page_url:
  #   - if extracted_url is relative, completes it with the protocol,
  #     host and path from page_url (page_url is expected to be absolute!)
  #   - just returns extracted_url if it is absolute.
  def complete_extracted_url(extracted_url, page_url)
    extracted_uri = URI.parse(extracted_url)
    page_uri = URI.parse(page_url)

    if extracted_uri.absolute?
      extracted_url 

    else
      raise ArgumentError.new('page_url must be absolute if extracted_url isn\'t!') unless page_uri.absolute?

      if extracted_url =~ %r{\A/}
        # Starts with '/', root of page_url's domain
        "#{page_uri.scheme}://#{page_uri.host}#{extracted_url}"
      else
        "#{page_uri.scheme}://#{page_uri.host}#{page_uri.path}/#{extracted_url}"
      end
    end
  end
end