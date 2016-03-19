module Elasticsearch
  module BulkIndexer
    ADAPTER = QueueAdapter::Redis

    module Callbacks

      extend ActiveSupport::Concern

      included do
        after_create  :record_creation
        after_destroy :record_deletion
      end

      def record_creation
        $redis.pipelined do
          ADAPTER.add_to_indexing_queue(ADAPTER.upgrade_queue, self.id)
          ADAPTER.remove_from_indexing_queue(ADAPTER.remove_queue, self.id)
        end
      end

      def record_deletion
        $redis.pipelined do
          ADAPTER.add_to_indexing_queue(ADAPTER.remove_queue, self.id)
          ADAPTER.remove_from_indexing_queue(ADAPTER.upgrade_queue, self.id)
        end
      end
    end
  end
end
