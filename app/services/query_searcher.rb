class QuerySearcher
  GOOGLE_SEARCH_URL= 'https://www.google.com/search'
  BING_SEARCH_URL= 'https://www.bing.com/search'

  def initialize
  end

  def call(engines, query)
  end

  def search_at_google(query)
    request(GOOGLE_SEARCH_URL, { q: query })
  end

  def search_at_bing(query)
    request(BING_SEARCH_URL, { q: query })
  end

  def request(url, params = {})
    response = Faraday.get(url, params)
    raise StandardError.new(response.body) if response.status != 200

    response.body
  end
end
