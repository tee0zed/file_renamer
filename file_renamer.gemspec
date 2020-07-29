# encoding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'file_renamer/version'

Gem::Specification.new do |spec|
  spec.name          = "file_renamer"
  spec.version       = FileRenamer::VERSION
  spec.authors       = ["Taras Zhuk"]
  spec.email         = ["tee@zed@gmail.com"]

  spec.platform      = Gem::Platform::RUBY
  spec.summary       = %q{Multiple files renamer script.}
  spec.description   = %q{File Renamer allows to rename bunch of files of similar extension or filename prefix all at once.}
  spec.homepage      = "https://github.com/tee0zed/file_renamer"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.executables   = 'filerenamer'
  spec.require_paths = ["lib", "bin"]

  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
end
