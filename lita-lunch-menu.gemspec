Gem::Specification.new do |spec|
  spec.name          = 'lita-lunch-menu'
  spec.version       = '0.1.0'
  spec.authors       = ['Olli Tapaninen']
  spec.email         = ['ollitapa@gmail.com']
  spec.description   = 'Lita-chatbot handler that provides lunch menus for different restaurants.'
  spec.summary       = 'Lita-chatbot handler that provides lunch menus for different restaurants.'
  spec.license       = 'MIT License'
  spec.metadata      = { 'lita_plugin_type' => 'handler' }

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'date'
  spec.add_runtime_dependency 'lita'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'solargraph'
  spec.add_development_dependency 'timecop'
  spec.add_development_dependency 'webmock'
end