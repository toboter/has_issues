$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "has_issues/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "has_issues"
  s.version     = HasIssues::VERSION
  s.authors     = ["Tobias Schmidt"]
  s.email       = ["t.schmidt@rubidat.de"]
  s.homepage    = "http://github.com/toboter/has_issues"
  s.summary     = "Allows users to create issues with comments on any model in your application."
  s.description = "A Rails engine for issues."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.0", ">= 5.0.0.1"
  s.add_dependency "jquery-rails"
  s.add_dependency "bootstrap-sass", "~> 3.3.6"
  s.add_dependency "will_paginate-bootstrap"
  s.add_dependency "font-awesome-rails"
  s.add_dependency "simple_form"
  s.add_dependency "search_cop", "~> 1.0.8"
  s.add_dependency "redcarpet"
  
  
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "byebug"
end
