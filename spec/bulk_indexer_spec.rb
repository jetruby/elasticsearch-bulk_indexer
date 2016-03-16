require 'spec_helper'

RSpec.describe Elasticsearch::BulkIndexer do
  describe '#config' do
    it { expect(described_class.queue_adapter).to eq :redis }
    it { expect(described_class.background_adapter).to eq :sidekiq }
    it { expect(described_class.orm).to eq :active_record }
    it { expect(described_class.queue).to eq :default }
    it { expect(described_class.reccurence).to be_a_kind_of Proc }

    context 'when config was changed' do
      before do
        described_class.config do |f|
          f.queue_adapter = nil
          f.background_adapter = nil
          f.orm = nil
          f.queue = nil
          f.reccurence = nil
        end
      end

      it { expect(described_class.queue_adapter).to eq nil }
      it { expect(described_class.background_adapter).to eq nil }
      it { expect(described_class.orm).to eq nil }
      it { expect(described_class.queue).to eq nil }
      it { expect(described_class.reccurence).to eq nil }
    end
  end
end
