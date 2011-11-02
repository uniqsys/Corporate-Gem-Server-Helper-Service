$:<< File.join(File.dirname(__FILE__), '..', 'lib')
$:<< File.join(File.dirname(__FILE__), '..', 'spec/support')

require 'gem_app'
require 'capybara'
require 'capybara/dsl'
require 'rspec'

Capybara.app = Sinatra::Application
Sinatra::Application.environment = :test
Bundler.require :default, Sinatra::Application.environment

RSpec.configure do |config|
  config.include Capybara::DSL
end