# frozen_string_literal: true

require 'rails_helper'

describe QuerySearcher do
  let(:query_searcher) { described_class.new }

  describe '#call' do
    let(:query) { 'test' }

    context 'when google search engine is called' do
      subject(:call) { query_searcher.call(:google, query) }

      it 'calls search at google engine and returns html data' do
        VCR.use_cassette('query_searcher/request_google_success') do
          expect(call).to include '<title>test - Pesquisa Google</title>'
        end
      end
    end

    context 'when bing search engine is called' do
      subject(:call) { query_searcher.call(:bing, query) }

      it 'returns bing engine html data' do
        VCR.use_cassette('query_searcher/request_bing_success') do
          expect(call).to include '<title>test - Bing</title>'
        end
      end
    end
  end

  describe '#search_at_google' do
    subject(:search_at_google) { query_searcher.search_at_google(query) }

    context 'when a valid query is provided' do
      let(:query) { 'test' }

      it 'returns valid google data' do
        VCR.use_cassette('query_searcher/request_google_success') do
          expect(search_at_google).to include '<title>test - Pesquisa Google</title>'
        end
      end
    end
  end

  describe '#search_at_bing' do
    subject(:search_at_bing) { query_searcher.search_at_bing(query) }

    context 'when a valid query is provided' do
      let(:query) { 'test' }

      it 'returns valid bing data' do
        VCR.use_cassette('query_searcher/request_bing_success') do
          expect(search_at_bing).to include '<title>test - Bing</title>'
        end
      end
    end
  end

  describe '#request' do
    subject(:request) { query_searcher.request(url) }

    context 'when a valid url is provided' do
      let(:url) { 'https://example.com/' }

      it 'returns valid body data' do
        VCR.use_cassette('query_searcher/request_success') do
          expect(request).to include '<title>Example Domain</title>'
        end
      end
    end

    context 'when an invalid url is provided' do
      let(:url) { 'https://example.com/' }

      it 'raises a request exception' do
        VCR.use_cassette('query_searcher/request_fail') do
          expect { request }.to raise_error(StandardError, 'Internal Server Error')
        end
      end
    end
  end
end
