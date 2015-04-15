# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sell_object/version'

Gem::Specification.new do |spec|
  spec.name          = "sell_object"
  spec.version       = SellObject::VERSION
  spec.authors       = ["Daniel Ferraz"]
  spec.email         = ["d.ferrazm@gmail.com"]
  spec.description   = %q{Extensible solution to make it easy to export ruby objects to be used on price comparison shopping engines}
  spec.summary       = %q{Sell your Ruby on Rails objects on price comparison shopping engines}
  spec.homepage      = "http://github.com/dferrazm/sell_object"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version     = '>= 1.9.3'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency "nokogiri"
end
