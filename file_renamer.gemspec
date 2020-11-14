require './lib/file_renamer/version.rb'

Gem::Specification.new do |s|
  s.name              = %q{file_renamer}
  s.version           = "#{FileRenamer::VERSION}"
  s.date              = "#{Time.now.strftime("%F")}"
  s.summary           = %q{Bulk file renaming tool}
  s.license           = "MIT"
  s.platform          = Gem::Platform::RUBY

  s.files             = %w( README.md Rakefile LICENSE.txt Gemfile Gemfile.lock )
  s.files            += Dir.glob("lib/*")
  s.files            += Dir.glob("bin/*")
  s.files            += Dir.glob("spec/**/*")

  s.require_paths     = ["lib", "bin"]
  s.executables       = ["file_renamer"]
  s.homepage          = "http://github.com/tee0zed/file_renamer/"
  s.email             = "tee0zed@gmail.com"
  s.authors           = ["Tee Zed"]

  s.add_development_dependency "bundler", "~> 2.1"
  s.add_development_dependency "rake", "~> 13.0"
  s.add_development_dependency "rspec", "~> 3.10"
  s.add_runtime_dependency "thor", "~> 1.0"
end