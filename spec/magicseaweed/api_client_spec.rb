# frozen_string_literal: true

require 'support/webmock/fixtures'

RSpec.describe Magicseaweed::APIClient do
  include WebMock::Fixtures

  let(:api_client) { described_class.new(api_key: 'api_key', units: units) }
  let(:units) { nil }
  let(:uri) { 'https://magicseaweed.com/api/api_key' }
  let(:query) { {} }

  describe '#get_forecast' do
    subject(:get_forecast) do
      api_client.get_forecast(spot_id: 'spot_id', fields: fields)
    end

    let(:fields) { nil }
    let(:uri) { super() + '/forecast' }
    let(:query) { super().merge('spot_id' => 'spot_id') }
    let(:fixture_filename) { :success }

    before do
      response = fixture_response(fixture_filename)
      stub_request(:get, uri).with(query: query).to_return(response)
    end

    it 'returns the forecast as a hash' do
      expect(get_forecast)
        .to eq JSON.parse(fixture_response_body(fixture_filename))
    end

    context 'when units are specified' do
      let(:units) { 'eu' }
      let(:query) { super().merge('units' => 'eu') }
      let(:fixture_filename) { :success_eu_units }

      it 'returns measurements in specified units' do
        expect(get_forecast.first['swell']['unit']).to eq 'm'
      end
    end

    context 'when fields are specified' do
      let(:fields) { [:timestamp] }
      let(:query) { super().merge('fields' => 'timestamp') }
      let(:fixture_filename) { :success_timestamp_only }

      it 'returns only the requested fields' do
        expect(get_forecast.first.keys).to eq ['timestamp']
      end
    end

    context 'with an invalid spot id for the current api key' do
      let(:fixture_filename) { :failure_spot_invalid }

      specify do
        expect { get_forecast }.to raise_error(
          Magicseaweed::APIClient::Error,
          'Path, method, or object restricted for your API key.'
        )
      end
    end

    context 'with a non-existant spot id' do
      let(:fixture_filename) { :failure_spot_not_found }

      specify do
        expect { get_forecast }.to raise_error(
          Magicseaweed::APIClient::Error,
          'Invalid parameters were supplied and did not pass our ' \
          'validation, please double check your request.'
        )
      end
    end

    context 'with an invalid api key' do
      let(:fixture_filename) { :failure_key_invalid }

      specify do
        expect { get_forecast }.to raise_error(
          Magicseaweed::APIClient::Error, 'Internal Server Error'
        )
      end
    end
  end
end
