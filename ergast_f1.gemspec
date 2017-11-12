# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ergast_f1/version'

Gem::Specification.new do |spec|
  spec.name          = "ergast_f1"
  spec.version       = ErgastF1::VERSION
  spec.authors       = ["Nathan Burgess"]
  spec.email         = ["burgess.nathan28@gmail.com"]

  spec.summary       = %q{A Ruby wrapper for the ergast F1 API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"

  spec.add_runtime_dependency "json"
  spec.add_runtime_dependency "curb"

end
