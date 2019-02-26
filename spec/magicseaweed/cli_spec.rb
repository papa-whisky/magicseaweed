# frozen_string_literal: true

RSpec.describe Magicseaweed::CLI do
  let(:cli) { described_class.new }

  describe '#hello' do
    subject(:hello) { cli.hello(name) }

    context 'when NAME is "Ja Rule"' do
      let(:name) { 'Ja Rule' }

      specify { expect { hello }.to output("Hello #{name}\n").to_stdout }
    end
  end
end
