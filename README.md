# Elasticsearch BulkIndexer

Collection of useful stuff

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'elasticsearch-bulk_indexer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install elasticsearch-bulk_indexer

## Deploy

To deploy gem on S3 you should run Rake task `GEMGATE_AUTH=username:password bundle exec rake release`.

- `GEMGATE_AUTH` - is required. Used for HTTP auth.
