module Elasticsearch
  module BulkIndexer
    module BackgroundAdapter
      module Sidekiq
        class ClassMethods
          # Defines indexing worker
          def self.indexing_worker
            Elasticsearch::BulkIndexer::BackgroundAdapter::Sidekiq::Worker
          end
        end

        class Worker
          include Sidekiq::Worker

          sidekiq_options failures: true, retry: true, queue: Elasticsearch::Model::ClassMethodsProxy.queue

          # Performs async reindex
          def perform(klass, ids=nil)
            model = klass.constantize
            ids ||= $redis.lrange(model.__elasticsearch__.redis_key, 0, 100) #We need to use SSCAN here

            # Bulk code goes here
          end
        end
      end
    end
  end
end
