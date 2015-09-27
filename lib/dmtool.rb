require 'pry'
require 'byebug'
require 'pry-byebug'
require 'active_support'
require 'active_support/core_ext'
require 'optparse'

require 'core_extensions/string/prep'
require 'dmtool/version'
require 'dmtool/result'
require 'dmtool/errors'
require 'dmtool/die'
require 'dmtool/parser'
require 'dmtool/parser/die_directive'
require 'dmtool/parser/dice_string'
require 'dmtool/roller'
require 'dmtool/cli'
String.include CoreExtensions::String::Prep
module DMTool
end
