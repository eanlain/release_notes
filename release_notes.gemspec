# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'release_notes/version'

Gem::Specification.new do |spec|
  spec.name          = "release_notes"
  spec.version       = ReleaseNotes::VERSION
  spec.authors       = ["Brandon Robins"]
  spec.email         = ["brandon@ourlabel.com"]
  spec.summary       = "An easy way to incorporate and manage release notes."
  spec.description   = "An easy way to incorporate and manage release notes."
  spec.homepage      = "http://www.github.com/eanlain/release_notes"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.executables << 'release_notes'
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 10.1.1"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "cucumber", "~> 1.3.10"
  spec.add_development_dependency "aruba", "~> 0.5.4"

  spec.add_dependency "thor", "~> 0.18.1"
  spec.add_dependency "rails", "~> 4.0.0"
  spec.add_dependency "redcarpet", "~> 3.0.0"
end
