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
    @responses = @engine_searchers.map do |engine_searcher|
      engine_searcher.search(query)
    end
  end
end
