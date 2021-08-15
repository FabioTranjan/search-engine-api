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
end
