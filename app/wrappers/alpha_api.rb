require 'uri'
require 'net/http'

class AlphaApi
  def self.get_stock_info (symbol)
    url = URI("https://alpha-vantage.p.rapidapi.com/query?function=TIME_SERIES_DAILY&symbol=#{symbol}&outputsize=compact&datatype=json")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-key"] = ENV.fetch('API_KEY', nil)
    request["x-rapidapi-host"] = 'alpha-vantage.p.rapidapi.com'

    response = http.request(request)
    JSON.parse(response.body)
    
  end
end