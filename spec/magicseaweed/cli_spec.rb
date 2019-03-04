# frozen_string_literal: true

RSpec.describe Magicseaweed::CLI do
  let(:cli) { described_class.new }

  describe '#forecast' do
    subject(:forecast) { cli.forecast(api_key, spot_id) }

    let(:api_key) { 'api_key' }
    let(:spot_id) { 'spot_id' }
    let(:api_client) { Magicseaweed::APIClient.new(api_key: api_key) }

    before do
      allow(Magicseaweed::APIClient).to receive(:new)
        .with(api_key: api_key)
        .and_return(api_client)

      allow(api_client).to receive(:get_forecast)
        .with(spot_id: spot_id)
        .and_return('forecast')
    end

    it 'prints a basic forecast' do
      expect { forecast }.to output("forecast\n").to_stdout
    end
  end
end
