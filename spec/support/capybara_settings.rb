require 'resolv'

Capybara.register_driver :selenium do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  options = Selenium::WebDriver::Firefox::Options.new(profile: profile)

  Capybara::Selenium::Driver.new(
    app,
    url:     'http://selenium:4444/wd/hub',
    browser: :remote,
    options: options
  )
end

Capybara.configure do |config|
  config.default_driver = :selenium
  config.server_host = Resolv.getaddress(ENV['CAPYBARA_SERVER_HOST'])
  config.server_port = 3000
end
