lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'elasticsearch/bulk_indexer/version'

Gem::Specification.new do |spec|
  spec.name          = 'elasticsearch-bulk_indexer'
  spec.version       = Elasticsearch::BulkIndexer::VERSION
  spec.authors       = ['Alex Tatarnikov']
  spec.email         = ['alx.tatarnikov@outlook.com']
  spec.summary       = %q{BulkIndexer for elasticsearch-rails}
  spec.description   = %q{BulkIndexer for elasticsearch-rails}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'elasticsearch-model', '~> 0.1'

  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.1'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'activemodel', '> 4.0'
  spec.add_development_dependency 'test_construct', '~> 2.0'
end
