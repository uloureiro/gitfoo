# frozen_string_literal: true

require 'json'
require_relative 'connection.rb'

# Request provides methods to interact to Github's API in a resource agnostic
# way
class Request
  class << self
    def where(resource_path, query = {})
      response, status = get_json(resource_path, query)
      status == 200 ? response : errors(response)
    end

    def get(resource_path, id)
      response, status = get_json(resource_path, id)
      status == 200 ? response : errors(response)
    end

    private

    def errors(response)
      error = { errors: { status: response['status'], message: response['message'] } }
      response.merge(error)
    end

    def get_json(root_path, query = {})
      query_string = query.is_a?(String) ? query : query.map { |k, v| "#{k}=#{v}" }.join('&')
      path = query.empty? ? root_path : "#{root_path}/#{query_string}"
      response = api.get(path)
      [JSON.parse(response.body), response.status]
    end

    def api
      Connection.api
    end
  end
end
