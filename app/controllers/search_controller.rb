# frozen_string_literal: true

# Search controller class
class SearchController < ApplicationController
  def search
    render plain: 'OK'
  end

  def search_params
    params.permit(:engines, :query)
  end
end
