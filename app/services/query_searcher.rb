# frozen_string_literal: true

# Query Searcher class
class QuerySearcher
  attr_reader :engine_searchers

  def initialize(engines)
    raise ArgumentError, 'Provide at least one search engine argument' unless engines.present?

    @engine_searchers = engines.map do |engine|
      create_engine_searcher(engine)
    end
  end

  def search(query)
    raise ArgumentError, 'Provide a valid query text' unless query.present?

    @engine_searchers.map do |engine_searcher|
      html_data = engine_searcher.search(query)
      engine_searcher.parse(html_data)
    end.flatten
  end

  private

  def create_engine_searcher(engine)
    Object.const_get("EngineSearcher::#{engine.to_s.capitalize}").new
  rescue NameError => _e
    raise ArgumentError, "The search engine #{engine} is not implemented"
  end
end
