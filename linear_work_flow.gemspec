# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'linear_work_flow/version'

Gem::Specification.new do |spec|
  spec.name          = "linear_work_flow"
  spec.version       = LinearWorkFlow::VERSION
  spec.authors       = ["Rob Nichols"]
  spec.email         = ["robnichols@warwickshire.gov.uk"]

  spec.summary       = %q{A state machine for linear work flows}
  spec.description   = %q{LinearWorkFlow is a basic state machine for managing state change through a single linear path}
  spec.homepage      = "https://github.com/reggieb/linear_work_flow"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
