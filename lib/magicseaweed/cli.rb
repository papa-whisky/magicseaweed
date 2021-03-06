# frozen_string_literal: true

require 'magicseaweed/forecast'
require 'thor'

module Magicseaweed
  # Define commands for CLI
  class CLI < Thor
    desc 'forecast API_KEY SPOT_ID', 'print a forecast for SPOT_ID'
    def forecast(api_key, spot_id)
      forecast = Magicseaweed::Forecast.new(api_key: api_key, spot_id: spot_id)
      puts forecast
    end
  end
end
