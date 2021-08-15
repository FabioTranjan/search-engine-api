# frozen_string_literal: true

module EngineSearcher
  # Engine Query Searcher class
  class Google < Base
    GOOGLE_SEARCH_URL = 'https://www.google.com/search'

    def search(query)
      request(GOOGLE_SEARCH_URL, { q: query })
    end
  end
end
