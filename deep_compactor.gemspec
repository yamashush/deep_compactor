# frozen_string_literal: true

require_relative "lib/deep_compactor/version"

Gem::Specification.new do |spec|
  spec.name = "deep_compactor"
  spec.version = DeepCompactor::VERSION
  spec.authors = ["yamashush"]
  spec.email = ["38120991+yamashush@users.noreply.github.com"]

  spec.summary = "Deep Compactor is a gem to deep compact nested Array and Hash."
  spec.description = spec.summary
  spec.homepage = "https://github.com/yamashush/deep_compactor"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/yamashush/deep_compactor"
  spec.metadata["changelog_uri"] = "https://github.com/yamashush/deep_compactor/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
