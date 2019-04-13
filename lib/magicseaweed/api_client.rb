# frozen_string_literal: true

require 'json'
require 'net/http'

module Magicseaweed
  # Call the Magicseaweed API
  class APIClient
    class Error < StandardError; end

    HOST = 'magicseaweed.com'

    def initialize(api_key:, units: nil)
      @api_key = api_key
      @units = units
    end

    def get_forecast(spot_id:, fields: nil)
      @spot_id = spot_id
      @fields = fields

      Net::HTTP.get_response(forecast_uri).then(&method(:handle_response))
    end

    private

    attr_reader :api_key
    attr_reader :units
    attr_reader :spot_id
    attr_reader :fields

    def forecast_uri
      URI::HTTPS.build(
        host: HOST,
        path: api_path + '/forecast',
        query: spot_id_query + fields_query + units_query
      )
    end

    def api_path
      "/api/#{api_key}"
    end

    def spot_id_query
      "spot_id=#{spot_id}&"
    end

    def fields_query
      return '' unless fields

      "fields=#{[fields].flatten.join(',')}&"
    end

    def units_query
      return '' unless units

      "units=#{units}&"
    end

    def handle_response(response)
      raise Error, response.msg unless response.is_a? Net::HTTPSuccess

      body = JSON.parse(response.body)

      # The Magicseaweed API annoyingly returns error messages with a 200 status
      # code, so check for that before returning the body
      if body.is_a?(Hash) && body.key?('error_response')
        raise Error, body['error_response']['error_msg']
      end

      body
    end
  end
end
