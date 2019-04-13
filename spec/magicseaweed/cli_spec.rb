# frozen_string_literal: true

RSpec.describe Magicseaweed::CLI do
  let(:cli) { described_class.new }

  describe '#forecast' do
    subject(:forecast) { cli.forecast('api_key', 'spot_id') }

    let(:msw_forecast) do
      instance_double('Magicseaweed::Forecast', to_s: 'forecast')
    end

    before do
      allow(Magicseaweed::Forecast).to receive(:new)
        .with(api_key: 'api_key', spot_id: 'spot_id')
        .and_return(msw_forecast)
    end

    it 'prints a basic forecast' do
      expect { forecast }.to output("forecast\n").to_stdout
    end
  end
end
