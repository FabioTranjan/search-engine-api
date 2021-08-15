# frozen_string_literal: true

module EngineSearcher
  # Google Engine Searcher class
  class Google < Base
    GOOGLE_SEARCH_URL = 'https://www.google.com/search'

    def search(query)
      request(GOOGLE_SEARCH_URL, { q: query })
    end

    def parse(data)
    end
  end
end
