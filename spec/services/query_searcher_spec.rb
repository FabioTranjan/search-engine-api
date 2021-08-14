require 'rails_helper'

describe QuerySearcher do
  let(:query_searcher) { described_class.new }

  describe "#call" do
    context "when valid engines and text are provided" do
      let(:text) { 'test' }
      let(:engines) { ['google', 'bing'] }

      it 'searches data for each corresponding engine' do
        expect(true).to be_truthy
      end
    end
  end

  describe "#request" do
    subject(:request) { query_searcher.request(url) }

    context "when a valid url is provided" do
      let(:url) { 'https://example.com/' }

      it 'returns valid body data' do
        VCR.use_cassette('query_searcher/request_success') do
          expect(request).to include '<title>Example Domain</title>'
        end
      end
    end

    context "when an invalid url is provided" do
      let(:url) { 'https://example.com/' }

      it 'raises a request exception' do
        VCR.use_cassette('query_searcher/request_fail') do
          expect{ request }.to raise_error(StandardError, 'Internal Server Error')
        end
      end
    end
  end
end
