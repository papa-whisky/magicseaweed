# frozen_string_literal: true

require 'magicseaweed/api_client'

module Magicseaweed
  # Generate a forecast to be printed
  class Forecast
    def initialize(api_key:, spot_id:)
      @api_key = api_key
      @spot_id = spot_id
    end

    def to_s
      "Spot: #{spot_id}\nForecast:\n#{daily_ratings.join(', ')}"
    end

    private

    attr_reader :api_key
    attr_reader :spot_id

    def daily_ratings
      midday_ratings.map do |rating|
        day_of_week(rating['localTimestamp']) +
          ': ' +
          ('*' * rating['solidRating'])
      end
    end

    def midday_ratings
      forecast.select do |forecast|
        Time.at(forecast['localTimestamp']).utc.hour == 12
      end
    end

    def forecast
      api_client
        .get_forecast(spot_id: spot_id, fields: %i[localTimestamp solidRating])
    end

    def api_client
      Magicseaweed::APIClient.new(api_key: api_key)
    end

    def day_of_week(local_timestamp)
      Time.at(local_timestamp).utc.strftime('%a')
    end
  end
end
