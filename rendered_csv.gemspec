# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rendered_csv/version'

Gem::Specification.new do |gem|
  gem.name          = "rendered_csv"
  gem.version       = RenderedCsv::VERSION
  gem.authors       = ["SpinDance, Inc."]
  gem.email         = ["rubygems@spindance.com"]
  gem.description   = %q{Adds a render_csv to your Rails 3.0+ controllers}
  gem.summary       = %q{Takes care of setting headers, naming your CSV file, and rendering a desired template}
  gem.homepage      = "https://github.com/spindance/rendered_csv"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'rails', '>= 3.0.0'
  gem.add_development_dependency 'mocha', '~> 0.13.1'
end
