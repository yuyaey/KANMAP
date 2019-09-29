# -*- encoding: utf-8 -*-
# stub: capistrano-ndenv 1.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "capistrano-ndenv".freeze
  s.version = "1.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Shaun Guth".freeze]
  s.date = "2018-03-01"
  s.description = "ndenv integration for Capistrano".freeze
  s.email = ["shaun.guth@gmail.com".freeze]
  s.homepage = "https://github.com/l8nite/capistrano-ndenv".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "This gem lets you use ndenv for node/npm integration in Capistrano".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<capistrano>.freeze, [">= 3.1.0", "< 4"])
      s.add_runtime_dependency(%q<sshkit>.freeze, ["~> 1.3"])
    else
      s.add_dependency(%q<capistrano>.freeze, [">= 3.1.0", "< 4"])
      s.add_dependency(%q<sshkit>.freeze, ["~> 1.3"])
    end
  else
    s.add_dependency(%q<capistrano>.freeze, [">= 3.1.0", "< 4"])
    s.add_dependency(%q<sshkit>.freeze, ["~> 1.3"])
  end
end
