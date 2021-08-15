# frozen_string_literal: true

module EngineSearcher
  # Bing Engine Searcher class
  class Bing < Base
    BING_SEARCH_URL = 'https://www.bing.com/search'

    def search(query)
      request(BING_SEARCH_URL, { q: query })
    end

    def parse(html_data)
      parsed_page = Nokogiri::HTML(html_data)
      results = parsed_page.css('li.b_algo')
      results.map do |result|
        {
          engine: 'bing',
          title: result.css('h2').text,
          link: result.css('div.b_attribution').text,
          description: result.css('p').text
        }
      end
    end
  end
end
