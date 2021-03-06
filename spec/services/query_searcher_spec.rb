# frozen_string_literal: true

require 'rails_helper'

describe QuerySearcher do
  let(:query_searcher) { described_class.new(engines) }

  describe '#search' do
    subject(:search) { query_searcher.search(query) }

    context 'when an invalid query text is provided' do
      let(:query) { nil }
      let(:engines) { ['google'] }

      it 'raises an Argument Error' do
        expect { search }.to raise_error(ArgumentError, 'Provide a valid query text')
      end
    end

    context 'when a valid query text is provided' do
      let(:query) { 'test' }

      context 'when no search engine is provided' do
        let(:engines) { [] }

        it 'raises an Argument Error' do
          expect { search }.to raise_error(ArgumentError, 'Provide at least one search engine argument')
        end
      end

      context 'when an invalid search engine is provided' do
        let(:engines) { ['yahoo'] }

        it 'returns nothing' do
          expect { search }.to raise_error(ArgumentError, 'The search engine yahoo is not implemented')
        end
      end

      context 'when only the google search engine is provided' do
        let(:engines) { ['google'] }

        it 'returns multiple search results' do
          VCR.use_cassette('engine_searcher/request_google_success') do
            expect(search.count).to eq 10
          end
        end

        it 'searches the query text on google' do
          VCR.use_cassette('engine_searcher/request_google_success') do
            expect(search.last[:engine]).to eq('google')
            expect(search.last[:title]).to eq('Apply for the Test and Isolate support payment | Service NSW')
          end
        end
      end

      context 'when both google and bing search engines are provided' do
        let(:engines) { %w[google bing] }

        it 'returns multiple search results' do
          VCR.use_cassette('engine_searcher/request_google_and_bing_success') do
            expect(search.count).to eq 18
          end
        end

        it 'searches the query text both on google and bing' do
          VCR.use_cassette('engine_searcher/request_google_and_bing_success') do
            expect(search.first).to eq(
              {
                description: "Use Speedtest em todos seus dispositivos com nossos aplicativos gratuitos para celular e "\
                             "computador.\nSpeedtest para Android ?? Speedtest para Windows ?? Aplicativos Speedtest",
                engine: 'google',
                link: 'https://google.com/url?q=https://www.speedtest.net/pt&sa=U&ved=2ahUKEwif3bvl_rHyAhUPHbkGHd0FAnAQFnoECAoQAQ&usg=AOvVaw1OiD0Vf0hrsEiXSZCA4QET',
                title: 'Speed Test'
              }
            )
            expect(search.last).to eq(
              {
                description: '??? O Teste de Velocidade do Tecnoblog tem a tecnologia Speed Test da nPerf, o veloc??metro ?? '\
                             'compat??vel com todas as conex??es: cabo, sat??lite, Wi-Fi e 4G.',
                engine: 'bing',
                link: 'https://tecnoblog.net/teste-de-velocidade',
                title: 'Teste de velocidade de Internet | Speed Test | Tecnoblog'
              }
            )
          end
        end
      end
    end
  end
end
