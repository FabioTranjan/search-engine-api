# frozen_string_literal: true

# Query Searcher class
class QuerySearcher
  attr_reader :engine_searchers

  def initialize(engines)
    @engine_searchers = engines.map do |engine|
      Object.const_get("EngineSearcher::#{engine.to_s.capitalize}").new
    end
  end

  def search(query)
    @engine_searchers.map do |engine_searcher|
      html_data = engine_searcher.search(query)
      engine_searcher.parse(html_data)
    end.flatten
  end
end
