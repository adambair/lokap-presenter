# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name    = "lokap-presenter"
  spec.version = '0.0.1'
  spec.authors = ["Adam Bair"]
  spec.email   = ["adambair@gmail.com"]

  spec.summary     = "A view presenter for those with discerning taste"
  spec.description = ""
  spec.homepage    = "https://github.com/adambair/lokap-presenter"

  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = ""

  spec.metadata["homepage_uri"]    = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"]   = spec.homepage

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
end
