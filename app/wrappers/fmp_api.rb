require 'uri'
require 'net/http'

class FmpApi
  def self.get_stock_info
    api_key = ENV.fetch('FMP_API_KEY', nil)
    uri = URI.parse("https://financialmodelingprep.com/api/v3/stock/list?apikey=#{api_key}")
    request = Net::HTTP::Get.new(uri)
    request["Upgrade-Insecure-Requests"] = "1"

    req_options = {
        use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    data = JSON.parse(response.body)
    $stock_data = {}
    data.each do |entry|
      if entry["type"] == "stock" && entry["exchangeShortName"] == "NASDAQ"
        $stock_data[entry["symbol"]] = {name: entry["name"], price: entry["price"]}
      end
    end
  end
end