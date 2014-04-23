# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'backsnap/version'

Gem::Specification.new do |spec|
  spec.name          = "backsnap"
  spec.version       = Backsnap::VERSION
  spec.authors       = ["David Villarama", "Roy Lee", "Tosin"]
  spec.email         = ["david_villarama@yahoo.com"]
  spec.summary       = %q{aws snapshot utility}
  spec.description   = %q{aws snapshot utility}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_dependency "aws-sdk"
  spec.add_dependency "settingslogic"
  spec.add_dependency "thor"
  spec.add_dependency "highline"
end
