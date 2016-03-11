require 'elasticsearch/bulk_indexer/callbacks'

Dir[Rails.root.join('elasticsearch/bulk_indexer/queue_adapter/*.rb')].each { |file| require file }
Dir[Rails.root.join('elasticsearch/bulk_indexer/background_adapter/*.rb')].each { |file| require file }
Dir[Rails.root.join('elasticsearch/bulk_indexer/orm/*.rb')].each { |file| require file }

module Elasticsearch
  module BulkIndexer
    # Defines which adapter will be used for storing data about indexing queue
    # Defaults to Redis
    # Only Redis currently available
    mattr_accessor :queue_adapter
    @@queue_adapter = :redis

    # Defines which adapter will be used for background processing
    # Defaults to Sidekiq
    # Only Sidekiq currently available
    mattr_accessor :background_adapter
    @@background_adapter = :sidekiq

    # The ORM which will be extended with methods for async indexing
    # Defaults to ActiveRecord
    # Only ActiveRecord currently available
    mattr_accessor :orm
    @@orm = :active_record

    # Defines queue name for indexing workers
    # default by default
    mattr_accessor :queue
    @@queue = :default

    # Defines way to setup
    def self.config
      yield self
    end

    # Extends Elasticsearch::Model::Proxy
    def self.included(base)
      base.class_eval do
        Elasticsearch::Model::ClassMethodsProxy.class_eval do
          include Elasticsearch::BulkIndexer::BackgroundAdapter.const_get(background_adapter.to_s.classify)::ClassMethods
          include Elasticsearch::BulkIndexer::QueueAdapter.const_get(queue_adapter.to_s.classify)::ClassMethods
          include Elasticsearch::BulkIndexer::Orm.const_get(orm.to_s.classify)::ClassMethods
        end

        Elasticsearch::Model::InstanceMethodsProxy.class_eval do
          include Elasticsearch::BulkIndexer::QueueAdapter.const_get(queue_adapter.to_s.classify)::InstanceMethods
          include Elasticsearch::BulkIndexer::Orm.const_get(orm.to_s.classify)::InstanceMethods
        end
      end
    end
  end
end
