# frozen_string_literal: true

module EngineSearcher
  # Google Engine Searcher class
  class Google < Base
    GOOGLE_SEARCH_URL = 'https://www.google.com/search'

    def search(query)
      request(GOOGLE_SEARCH_URL, { q: query })
    end

    def parse(html_data)
      parsed_page = Nokogiri::HTML(html_data)
      results = parsed_page.css('div.xpd')
      results.map do |result|
        next unless result.css('h3')
        {
          engine: 'google',
        }
      end
    end
  end
end
