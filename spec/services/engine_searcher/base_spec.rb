# frozen_string_literal: true

require 'rails_helper'

describe EngineSearcher::Base do
  let(:engine_searcher) { described_class.new }

  describe '#request' do
    subject(:request) { engine_searcher.request(url) }

    context 'when a valid url is provided' do
      let(:url) { 'https://example.com/' }

      it 'returns valid body data' do
        VCR.use_cassette('engine_searcher/request_success') do
          expect(request).to include '<title>Example Domain</title>'
        end
      end
    end

    context 'when an invalid url is provided' do
      let(:url) { 'https://example.com/' }

      it 'raises a request exception' do
        VCR.use_cassette('engine_searcher/request_fail') do
          expect { request }.to raise_error(RuntimeError, 'Internal Server Error')
        end
      end
    end
  end
end
