require 'spec_helper'

RSpec.describe Elasticsearch::BulkIndexer do
  describe '#config' do
    let(:module_definition) { Elasticsearch::BulkIndexer }

    it { expect(module_definition.queue_adapter).to eq :redis }
    it { expect(module_definition.background_adapter).to eq :sidekiq }
    it { expect(module_definition.orm).to eq :active_record }
    it { expect(module_definition.queue).to eq :default }
    it { expect(module_definition.reccurence).to be_a_kind_of Proc }

    context 'when config was changed' do
      before do
        module_definition.config do |f|
          f.queue_adapter = nil
          f.background_adapter = nil
          f.orm = nil
          f.queue = nil
          f.reccurence = nil
        end
      end

      it { expect(module_definition.queue_adapter).to eq nil }
      it { expect(module_definition.background_adapter).to eq nil }
      it { expect(module_definition.orm).to eq nil }
      it { expect(module_definition.queue).to eq nil }
      it { expect(module_definition.reccurence).to eq nil }
    end
  end
end
