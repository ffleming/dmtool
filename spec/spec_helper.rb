def key_location
  spec = Gem::Specification.find_by_name('dmtool')
  File.join(spec.gem_dir, '.code_climate.secret')
end

def set_code_climate_key!
  ENV['CODECLIMATE_REPO_TOKEN'] = File.read key_location rescue nil
end

set_code_climate_key!

require 'simplecov'
require 'codeclimate-test-reporter'
SimpleCov.start
# CodeClimate::TestReporter.start
require 'dmtool'
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
