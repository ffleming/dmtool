require 'pry'
require 'byebug'
require 'pry-byebug'
require 'active_support'
require 'active_support/core_ext'

require 'core_extensions/string/prep'
require 'dmtool/version'
require 'dmtool/result'
require 'dmtool/errors'
require 'dmtool/die'
require 'dmtool/fudge_die'
require 'dmtool/parser'
require 'dmtool/parser/directive'
require 'dmtool/parser/die_directive'
require 'dmtool/parser/dice_string'
require 'dmtool/roller'
String.include CoreExtensions::String::Prep
module DMTool
end
