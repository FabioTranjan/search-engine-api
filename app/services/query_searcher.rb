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
    Faraday.get url
  end
end
