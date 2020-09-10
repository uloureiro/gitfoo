# frozen_string_literal: true

require 'faraday'

# Connection contains the core method to provide a fully functional connection
# to Github's API
class Connection
  BASE_URL = 'https://api.github.com/'

  def self.api
    Faraday.new(url: BASE_URL) do |faraday|
      faraday.response :logger
      faraday.adapter :net_http
      faraday.headers['Content-Type'] = 'application/json'
      faraday.headers['Accept'] = 'application/vnd.github.v3+json'
    end
  end
end
