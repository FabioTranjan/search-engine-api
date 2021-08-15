# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchController, type: :request do
  let(:parsed_response) { JSON.parse(response.body) }

  describe '#search' do
    let(:params) do
      {
        engines: 'google,bing',
        query: 'test'
      }
    end

    before do
      VCR.use_cassette('engine_searcher/request_google_and_bing_success') do
        get '/search', params: params
      end
    end

    context 'when searching with google and bing engines' do
      it 'returns success status' do
        expect(response.status).to eq 200
      end

      it 'returns aggregate responses' do
        expect(parsed_response.count).to eq 18
      end

      it 'returns the searched json data' do
        expect(parsed_response.first).to eq(
          {
            'engine' => 'google',
            'title' => 'Speed Test',
            'link' => 'https://google.com/url?q=https://www.speedtest.net/pt&sa=U&ved=2ahUKEwif3bvl_rHyAhUPHbkGHd0FAnAQFnoECAoQAQ&usg=AOvVaw1OiD0Vf0hrsEiXSZCA4QET',
            'description' => 'Use Speedtest em todos seus dispositivos com nossos aplicativos gratuitos para celular e '\
                             'computador.\nSpeedtest para Android · Speedtest para Windows · Aplicativos Speedtest'
          }
        )
      end
    end
  end
end
