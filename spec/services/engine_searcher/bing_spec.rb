# frozen_string_literal: true

require 'rails_helper'

describe EngineSearcher::Bing do
  let(:engine_searcher) { described_class.new }

  describe '#search' do
    subject(:search) { engine_searcher.search(query) }

    context 'when a valid query is provided' do
      let(:query) { 'test' }

      it 'returns valid bing data' do
        VCR.use_cassette('engine_searcher/request_bing_success') do
          expect(search).to include '<title>test - Bing</title>'
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
        VCR.use_cassette('engine_searcher/request_bing_success') do
          Faraday.get('https://www.bing.com/search?q=test').body
        end
      end

      it 'returns multiple results' do
        expect(parse.count).to eq 8
      end

      it 'returns parsed data' do
        expect(parse.first).to eq({
          engine: 'bing',
          title: 'Speedtest by Ookla - Teste de Velocidade de Conexão da ...Explore mais',
          link: 'https://www.speedtest.net/pt',
          description: 'Use Speedtest em todos seus dispositivos com nossos aplicativos gratuitos para celular e computador.'
        }) 
      end
    end
  end
end
