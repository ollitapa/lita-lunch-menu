require 'simplecov'
require 'coveralls'
SimpleCov.formatter =
  SimpleCov::Formatter::MultiFormatter
  .new([
         SimpleCov::Formatter::HTMLFormatter,
         Coveralls::SimpleCov::Formatter
       ])
SimpleCov.start { add_filter '/spec/' }

require 'lita-lunch-menu'
require 'lita/rspec'

# A compatibility mode is provided for older plugins upgrading from Lita 3. Since this plugin
# was generated with Lita 4, the compatibility mode should be left disabled.
Lita.version_3_compatibility_mode = false

# Disable web connections
require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)
