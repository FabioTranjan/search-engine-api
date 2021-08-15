# frozen_string_literal: true

module EngineSearcher
  # Engine Query Searcher class
  class Bing < Base
    BING_SEARCH_URL = 'https://www.bing.com/search'

    def search(query)
      request(BING_SEARCH_URL, { q: query })
    end
  end
end
