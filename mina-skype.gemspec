
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mina/skype/version"

Gem::Specification.new do |spec|
  spec.name          = "mina-skype"
  spec.version       = Mina::Skype::VERSION
  spec.authors       = ["Star Chow"]
  spec.email         = ["puma.puma07@gmail.com"]

  spec.summary       = %q{mina-skype is a small gem for sending mina deploy notifications to Skype.}
  spec.description   = %q{mina-skype is a small gem for sending mina deploy notifications to Skype.}
  spec.homepage      = "https://github.com/starchow/mina-skype"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "mina"
  spec.add_dependency "mina-hooks"
  spec.add_dependency "skype_bot"
end
