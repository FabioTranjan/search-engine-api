# frozen_string_literal: true

# Search controller class
class SearchController < ApplicationController
  def search
    query_params = search_params[:query]
    engines_params = search_params[:engines].split(',') if search_params[:engines]
    result = QuerySearcher.new(engines_params).search(query_params)
    render json: result.to_json
  rescue StandardError => e
    render json: e.message.to_json, status: 500
  end

  def search_params
    params.permit(:query, :engines)
  end
end
