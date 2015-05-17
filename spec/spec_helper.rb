require 'simplecov'
require 'codeclimate-test-reporter'
SimpleCov.start do
  add_filter '/spec/'
end
CodeClimate::TestReporter.start
require 'dmtool'
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
