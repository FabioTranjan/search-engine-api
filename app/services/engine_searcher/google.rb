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
        next unless result.css('h3').present?
        {
          engine: 'google',
          title: result.css('h3').text.force_encoding("ISO-8859-1").encode("UTF-8"),
          link: "https://google.com#{result.css('a').first['href']}",
          description: result.css('a').first.parent.next.next.text.force_encoding("ISO-8859-1").encode("UTF-8")
        }
      end.compact
    end
  end
end
