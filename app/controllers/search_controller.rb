class SearchController < ApplicationController
  def search
  end

  def search_params
    params.permit(:engines, :text)
  end
end