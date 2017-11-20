# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "opera/version"

Gem::Specification.new do |spec|
  spec.name          = "opera"
  spec.version       = Opera::VERSION
  spec.authors       = ["tzmfreedom"]
  spec.email         = ["makoto_tajitsu@hotmail.co.jp"]

  spec.summary       = 'Request/Response Validator with OpenAPI on Rack Middleware'
  spec.description   = 'Request/Response Validator with OpenAPI on Rack Middleware'
  spec.homepage      = 'https://github.com/tzmfreedom/opera'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rack"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
