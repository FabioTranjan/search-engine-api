class SearchController < ApplicationController
  def search
  end

  def search_params
    params.permit(:engine, :text)
  end
end
