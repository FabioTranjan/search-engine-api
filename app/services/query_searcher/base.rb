# frozen_string_literal: true

module QuerySearcher
  # Query Search class
  class Base
    def call(engine, query)
      case engine
      when :google
        google_engine = Google.new
        google_engine.search(query)
      when :bing
        bing_engine = Bing.new
        bing_engine.search(query)
      end
    end

    def request(url, params = {})
      response = Faraday.get(url, params)
      raise StandardError, response.body if response.status != 200

      response.body
    end
  end
end
