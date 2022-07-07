# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name    = "lokap-presenter"
  spec.version = '0.0.1'
  spec.authors = ["Adam Bair"]
  spec.email   = ["adambair@gmail.com"]

  spec.licenses    = "Nonstandard"
  spec.summary     = "A view presenter for those with discerning taste"
  spec.homepage    = "https://github.com/adambair/lokap-presenter"

  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org/"

  spec.metadata["homepage_uri"]    = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/adambair/lokap-presenter/"
  spec.metadata["changelog_uri"]   = "https://github.com/adambair/lokap-presenter/blob/master/CHANGELOG.md"
end

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end

  spec.require_paths = ["lib"]
end
