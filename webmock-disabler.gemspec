# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "webmock/disabler/version"

Gem::Specification.new do |s|
  s.name        = "webmock-disabler"
  s.version     = WebMock::Disabler::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Danny Burkes"]
  s.email       = ["dburkes@netable.com"]
  s.homepage    = %q{http://github.com/dburkes/webmock-disabler}
  s.summary     = %q{Disable and re-enable WebMock with ease}
  s.description = %q{Disable and re-enable WebMock with ease}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_runtime_dependency(%q{webmock}, [">= 1.6.4", "< 2.0.0"])
  s.add_development_dependency(%q{rspec})
end
