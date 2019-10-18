
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rspec-on_failure/version"

Gem::Specification.new do |spec|
  spec.name          = "rspec-on_failure"
  spec.version       = RSpecOnFailure.version
  spec.authors       = ["Tyler Rick"]
  spec.email         = ["tyler@tylerrick.com"]

  spec.summary       = %q{Provide additional debugging information to be printed if a test fails.}
  spec.homepage      = "https://github.com/TylerRick/rspec-on_failure"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 2.0"
  spec.add_development_dependency "rake", ">= 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
