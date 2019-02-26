# frozen_string_literal: true

module WebMock
  module Fixtures
    private

    def fixture_response(filename)
      File.new(fixture_path(filename))
    end

    def fixture_response_body(filename)
      File.readlines(fixture_path(filename)).last
    end

    def fixture_path(filename)
      File.join(
        File.dirname(__FILE__), '../../fixtures/webmock', "#{filename}.txt"
      )
    end
  end
end
