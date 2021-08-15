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
end
