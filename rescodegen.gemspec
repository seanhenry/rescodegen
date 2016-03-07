# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rescodegen/version'

Gem::Specification.new do |spec|
  spec.name          = "rescodegen"
  spec.version       = Rescodegen::VERSION
  spec.authors       = ["Sean Henry"]
  spec.email         = ["hello@seanhenry.codes"]

  spec.summary       = %q{Converts localised string files into Objective-C and Swift code.}
  spec.homepage      = "https://github.com/seanhenry/rescodegen"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "plist", "= 3.2.0"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "simplecov", "~> 0.11"
  spec.add_development_dependency "codeclimate-test-reporter", "~> 0.5"
  spec.add_development_dependency "rspec", "~> 3.4"
end
