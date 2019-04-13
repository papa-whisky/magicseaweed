# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'magicseaweed/version'

Gem::Specification.new do |s|
  s.name     = 'magicseaweed'
  s.version  = Magicseaweed::VERSION
  s.summary  = 'Magicseaweed surf reports via CLI.'
  s.homepage = 'https://github.com/papa-whisky/magicseaweed'
  s.author   = 'Paul Williams'
  s.email    = 'paul@pdwilliams.net'
  s.license  = 'MIT'

  s.executables = 'magicseaweed'
  s.files       = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0")
                     .reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  s.add_dependency 'thor'

  s.add_development_dependency 'bundler', '~> 2.0'
  s.add_development_dependency 'pry', '~> 0.12.0'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'rubocop', '~> 0.64.0'
  s.add_development_dependency 'rubocop-rspec', '~> 1.0'
  s.add_development_dependency 'webmock', '~> 3.5.0'
end
