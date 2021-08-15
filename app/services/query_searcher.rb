# frozen_string_literal: true

# Query Searcher class
class QuerySearcher
  attr_reader :engine_searchers

  def initialize(engines)
    raise ArgumentError, 'Provide at least one search engine argument' unless engines.present?

    @engine_searchers = engines.map do |engine|
      Object.const_get("EngineSearcher::#{engine.to_s.capitalize}").new
    end
  end

  def search(query)
    raise ArgumentError, 'Provide a valid query text' unless query.present?

    @engine_searchers.map do |engine_searcher|
      html_data = engine_searcher.search(query)
      engine_searcher.parse(html_data)
    end.flatten
  end
end
