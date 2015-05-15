# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dmtool/version'

Gem::Specification.new do |spec|
  spec.name          = "dmtool"
  spec.version       = DMTool::VERSION
  spec.authors       = ["Forrest Fleming"]
  spec.email         = ["ffleming@gmail.com"]

  spec.summary       = %q{Suite of tools for RPGs}
  spec.description   = %q{Suite of tools for RPGs.  An excuse to create a fun little parser.}
  spec.homepage      = "http://github.com/ffleming/dmtool"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1", ">= 1.6.5"
  spec.add_development_dependency "rspec", "~> 3"
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'byebug', '~> 2'
end
