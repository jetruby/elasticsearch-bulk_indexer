module Elasticsearch
  module BulkIndexer
    module QueueAdapter
      module Redis
        class ClassMethods
          # Adds specified id to the indexing queue
          def self.add_to_indexing_queue(redis_key, id)
            $redis.sadd(redis_key, id)
          end

          # Removes id from the indexing queue
          def self.remove_from_indexing_queue(redis_key, id)
            $redis.srem(redis_key, id)
          end

          # Returns all ids in the indexing queue
          def self.indexing_queue
            $redis.smembers(redis_key)
          end

          # Defines redis keys
          def self.upgrade_queue
            "elasticsearch:bulk_indexer:update_indexing_queue:#{target.name.underscore}"
          end

          def self.remove_queue
            "elasticsearch:bulk_indexer:remove_indexing_queue:#{target.name.underscore}"
          end
        end

        class InstanceMethods
          # Adds object to the indexing queue
          def add_to_indexing_queue
            self.class.__elasticsearch__.add_to_indexing_queue(id)
          end

          # Removes object from the indexing queue
          def remove_from_indexing_queue
            self.class.__elasticsearch__.remove_from_indexing_queue(id)
          end
        end
      end
    end
  end
end
