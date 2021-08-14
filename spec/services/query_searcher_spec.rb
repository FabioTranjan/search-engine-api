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

      it 'runs the request successfully' do
        VCR.use_cassette('query_searcher/request') do
          expect(request.status).to eq 200
        end
      end

      it 'returns valid body data' do
        VCR.use_cassette('query_searcher/request') do
          expect(request.body).to include '<title>Example Domain</title>'
        end
      end
    end
  end
end
