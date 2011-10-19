# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "trusted_resource/version"

Gem::Specification.new do |s|
  s.name        = "trusted_resource"
  s.version     = TrustedResource::VERSION
  s.authors     = ["Richard Allaway"]
  s.email       = ["richard@bookish.com"]
  s.homepage    = ""
  s.summary     = %q{ActiveReosurce for internal services}
  s.description = %q{Patch for ARes to initializes objects from xml or json containing protected attributes, such as id}

  s.rubyforge_project = "trusted_resource"

  s.add_dependency("activeresource", ">= 3.0")
  s.add_development_dependency("activerecord", ">= 3.0")
  s.add_development_dependency("rspec")

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
