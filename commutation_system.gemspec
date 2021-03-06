# -*- encoding: utf-8 -*-
require File.expand_path('../lib/commutation_system/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Sergey Sintyalev"]
  gem.email         = ["sintyalev@mail.ru"]
  gem.description   = %q{MY CommutationSystem}
  gem.summary       = %q{MY CommutationSystem}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "commutation_system"
  gem.require_paths = ["lib"]
  gem.version       = CommutationSystem::VERSION
end

 
