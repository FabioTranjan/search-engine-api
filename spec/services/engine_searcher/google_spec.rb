# frozen_string_literal: true

require 'rails_helper'

describe EngineSearcher::Google do
  let(:engine_searcher) { described_class.new }

  describe '#search' do
    subject(:search) { engine_searcher.search(query) }

    context 'when a valid query is provided' do
      let(:query) { 'test' }

      it 'returns valid google data' do
        VCR.use_cassette('engine_searcher/request_google_success') do
          expect(search).to include '<title>test - Pesquisa Google</title>'
        end
      end
    end
  end

  describe '#parse' do
    subject(:parse) { engine_searcher.parse(html_data) }

    context 'when invalid html data is provided' do
      let(:html_data) { nil }

      it 'returns nothing' do
        expect(parse.count).to eq 0
      end
    end

    context 'when valid html data is provided' do
      let(:html_data) do
        VCR.use_cassette('engine_searcher/request_google_success') do
          Faraday.get('https://www.google.com/search?q=test').body
        end
      end

      it 'returns multiple results' do
        expect(parse.count).to eq 10
      end

      it 'returns parsed engine' do
        expect(parse.first[:engine]).to eq('google')
      end

      it 'returns parsed title' do
        expect(parse.first[:title]).to eq('Speedtest by Ookla - Teste de Velocidade de Conexão da Internet')
      end

      it 'returns parsed link' do
        expect(parse.first[:link]).to eq('https://google.com/url?q=https://www.speedtest.net/pt&sa=U&ved=2ahUKEwit8bjdwbHyAhUOI7kGHQ6fCMMQFnoECAMQAQ&usg=AOvVaw2VAwO9-AHG3jaiwGr8h6aD')
      end

      it 'returns parsed description' do
        expect(parse.first[:description]).to include('Single Connection Test')
      end
    end
  end
end
