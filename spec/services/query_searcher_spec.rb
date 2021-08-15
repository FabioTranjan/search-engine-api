# frozen_string_literal: true

require 'rails_helper'

describe QuerySearcher do
  let(:query_searcher) { described_class.new(engines) }

  describe '#search' do
    subject(:search) { query_searcher.search('test') }

    context 'when a valid query text is provided' do
      let(:query) { 'test' }

      context 'when no search engine is provided' do
        let(:engines) { [] }

        it 'returns nothing' do
          expect(search).to be_empty
        end
      end

      context 'when an invalid search engine is provided' do
        let(:engines) { ['wrong'] }

        it 'returns nothing' do
          expect { search }.to raise_error(NameError, 'uninitialized constant EngineSearcher::Wrong')
        end
      end

      context 'when only the google search engine is provided' do
        let(:engines) { ['google'] }

        it 'searches the query text on google' do
          VCR.use_cassette('engine_searcher/request_google_success') do
            expect(search[0]).to include '<title>test - Pesquisa Google</title>'
          end
        end
      end

      context 'when both google and bing search engines are provided' do
        let(:engines) { %w[google bing] }

        it 'searches the query text both on google and bing' do
          VCR.use_cassette('engine_searcher/request_google_and_bing_success') do
            expect(search[0]).to include '<title>test - Pesquisa Google</title>'
            expect(search[1]).to include '<title>test - Bing</title>'
          end
        end
      end
    end
  end
end
