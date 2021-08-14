class QuerySearcher
  GOOGLE_BASE_SEARCH_URL= 'https://www.google.com.br/search'
  BING_BASE_SEARCH_URL= 'https://www.bing.com/search'

  def initialize
  end

  def call(engines, query)
  end

  def search_at_google(query)
  end

  def search_at_bing(query)
  end

  def request(url)
    response = Faraday.get(url)
    raise StandardError.new(response.body) if response.status != 200

    response.body
  end
end
