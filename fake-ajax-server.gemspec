# -*- encoding: utf-8 -*-
require File.expand_path('../lib/fake-ajax-server/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Rodrigo Rosenfeld Rosas"]
  gem.email         = ["rr.rosas@gmail.com"]
  gem.description   = %q{Fake your AJAX requests in your tests/specs.}
  gem.summary       = %q{Fake AJAX Server for jQuery requests}
  gem.homepage      = "http://github.com/rosenfeld/fake-ajax-server"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "fake-ajax-server"
  gem.require_paths = ["lib"]
  gem.version       = Fake::Ajax::Server::VERSION

  gem.add_dependency 'jquery-rails'
  gem.add_dependency 'sinon-rails'
end
