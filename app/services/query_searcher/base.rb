# frozen_string_literal: true

# Query Search class
module QuerySearcher
  class Base
    GOOGLE_SEARCH_URL = 'https://www.google.com/search'
    BING_SEARCH_URL = 'https://www.bing.com/search'
  
    def call(engine, query)
      case engine
      when :google
        search_at_google(query)
      when :bing
        search_at_bing(query)
      end
    end
  
    def search_at_google(query)
      request(GOOGLE_SEARCH_URL, { q: query })
    end
  
    def search_at_bing(query)
      request(BING_SEARCH_URL, { q: query })
    end
  
    def request(url, params = {})
      response = Faraday.get(url, params)
      raise StandardError, response.body if response.status != 200
  
      response.body
    end
  end
end
