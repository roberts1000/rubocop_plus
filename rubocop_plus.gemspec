lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rubocop_plus/version"

Gem::Specification.new do |spec|
  spec.name          = "rubocop_plus"
  spec.version       = RubocopPlus::VERSION
  spec.authors       = ["roberts1000"]
  spec.email         = ["roberts@corlewsolutions.com"]

  spec.summary       = "Enhancements to the standard rubocop gem."
  spec.description   = "Enhancements to the standard rubocop gem."
  spec.homepage      = "https://github.com/roberts1000/rubocop_plus"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "pry", "~> 0.12.2"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "rspec", "~> 3.8.0"

  spec.add_dependency "cri", "~> 2.0"
  spec.add_dependency "rubocop", RubocopPlus::RUBOCOP_VERSION.to_s
  spec.add_dependency "rubocop-performance", "~> 1.4.0"
  spec.add_dependency "rubocop-rails", "~> 2.4.1"
end
