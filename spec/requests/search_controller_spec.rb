# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchController, type: :request do
  describe '#search' do
    it do
      params = {
        engines: 'google,bing',
        query: 'test'
      }
      VCR.use_cassette('engine_searcher/request_google_and_bing_success') do
        get '/search', params: params
      end

      expect(response.status).to eq 200
    end
  end
end
