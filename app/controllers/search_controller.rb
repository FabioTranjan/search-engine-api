# frozen_string_literal: true

# Search controller class
class SearchController < ApplicationController
  def search
    query_params = search_params[:query]
    engines_params = search_params[:engines].split(',') if search_params[:engines]
    result = QuerySearcher.new(engines_params).search(query_params)
    render json: result.to_json
  end

  def search_params
    params.permit(:query, :engines)
  end
end
