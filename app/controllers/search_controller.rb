# frozen_string_literal: true

# Search controller class
class SearchController < ApplicationController
  def search
    results = []
    engines_params = params[:engines].split(',') if params[:engines]
    engines_params.map do |engine|
      if engine == 'bing'
        response = Faraday.get('https://www.bing.com/search', { q: params[:query] })
        html_data = response.body

        parsed_page = Nokogiri::HTML(html_data)
        results.append parsed_page.css('li.b_algo').map do |result|
          {
            engine: 'bing',
            title: result.css('h2').text,
            link: result.css('div.b_attribution').text,
            body: result.css('p').text
          }
        end
      end
      if engine == 'google'
        response = Faraday.get('https://www.google.com/search', { q: params[:query] })
        html_data = response.body

        parsed_page = Nokogiri::HTML(html_data)
        results.append parsed_page.css('div.xpd').map do |result|
          next unless result.css('h3').present?
  
          {
            engine: 'google',
            title: result.css('h3').text.force_encoding('ISO-8859-1').encode('UTF-8'),
            link: "https://google.com#{result.css('a').first['href']}",
            body: result.css('a').first.parent.next.next.text.force_encoding('ISO-8859-1').encode('UTF-8')
          }
        end
      end
    end
    render json: results.to_json
  end
end
