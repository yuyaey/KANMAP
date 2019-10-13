# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'rails/all' 
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rspec'

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

abort("The Rails environment is running in production mode!") if Rails.env.production?


begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.before(:all) do
    FactoryBot.reload
  end

  config.before(:each) do |example|
    if example.metadata[:type] == :system
      if example.metadata[:js]
        driven_by :selenium_chrome_headless, screen_size: [1400, 1400]
      else
        driven_by :rack_test
      end
    end
  end

  config.include FactoryBot::Syntax::Methods

end
