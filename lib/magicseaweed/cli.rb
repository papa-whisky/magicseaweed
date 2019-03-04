# frozen_string_literal: true

require 'magicseaweed/api_client'
require 'thor'

module Magicseaweed
  # Define commands for CLI
  class CLI < Thor
    desc 'forecast API_KEY SPOT_ID', 'print a forecast for SPOT_ID'
    def forecast(api_key, spot_id)
      api_cilent = Magicseaweed::APIClient.new(api_key: api_key)
      forecast = api_cilent.get_forecast(spot_id: spot_id)
      puts forecast
    end
  end
end
