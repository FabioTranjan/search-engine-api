# frozen_string_literal: true

module EngineSearcher
  # Bing Engine Searcher class
  class Bing < Base
    BING_SEARCH_URL = 'https://www.bing.com/search'

    def search(query)
      request(BING_SEARCH_URL, { q: query })
    end

    def parse(data)
    end
  end
end
