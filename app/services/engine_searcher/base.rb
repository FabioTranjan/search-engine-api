# frozen_string_literal: true

module EngineSearcher
  # Engine Searcher class
  class Base
    def request(url, params = {})
      response = Faraday.get(url, params)
      raise StandardError, response.body if response.status != 200

      response.body
    end
  end
end
