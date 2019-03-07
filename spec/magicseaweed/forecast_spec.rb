# frozen_string_literal: true

require 'support/webmock/fixtures'

RSpec.describe Magicseaweed::Forecast do
  include WebMock::Fixtures

  let(:forecast) { described_class.new(api_key: 'api_key', spot_id: 'spot_id') }

  describe '#to_s' do
    subject(:to_s) { forecast.to_s }

    let(:api_client) { instance_double('Magicseaweed::APIClient') }

    before do
      allow(Magicseaweed::APIClient).to receive(:new)
        .with(api_key: 'api_key').and_return(api_client)

      allow(api_client).to receive(:get_forecast)
        .with(spot_id: 'spot_id', fields: 'localTimestamp,solidRating')
        .and_return(JSON.parse(fixture_response_body(:success)))
    end

    it 'returns a forecast for the next five days' do
      expect(to_s).to eq "Spot: spot_id\nForecast:\n" \
        'Tue: , Wed: **, Thu: *, Fri: *, Sat: **'
    end
  end
end
