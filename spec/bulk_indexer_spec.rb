require 'spec_helper'

RSpec.describe Elasticsearch::BulkIndexer do
  describe '#config' do
    subject { Elasticsearch::BulkIndexer.config(&config) }

    let(:default_queue_adapter) { :redis }
    let(:default_background_adapter) { :sidekiq }
    let(:default_orm) { :active_record }
    let(:default_queue) { :default }
    let(:config) { ->(f) {} }

    it { expect { subject }.not_to change { described_class.queue_adapter }.from(default_queue_adapter) }
    it { expect { subject }.not_to change { described_class.background_adapter }.from(default_background_adapter) }
    it { expect { subject }.not_to change { described_class.orm }.from(default_orm) }
    it { expect { subject }.not_to change { described_class.queue }.from(default_queue) }
    it { expect { subject }.not_to change { described_class.recurrence }.from(kind_of(Proc)) }

    context 'when queue_adapter is changed' do
      let(:config) { ->(f) { f.queue_adapter = nil } }

      it { expect { subject }.to change { described_class.queue_adapter }.from(default_queue_adapter).to(nil) }
    end

    context 'when background_adapter is changed' do
      let(:config) { ->(f) { f.background_adapter = nil } }

      it { expect { subject }.to change { described_class.background_adapter }.from(default_background_adapter).to(nil) }
    end

    context 'when orm is changed' do
      let(:config) { ->(f) { f.orm = nil } }

      it { expect { subject }.to change { described_class.orm }.from(default_orm).to(nil) }
    end

    context 'when queue is changed' do
      let(:config) { ->(f) { f.queue = nil } }

      it { expect { subject }.to change { described_class.queue }.from(default_queue).to(nil) }
    end

    context 'when recurrence is changed' do
      let(:config) { ->(f) { f.recurrence = nil } }

      it { expect { subject }.to change { described_class.recurrence }.from(kind_of(Proc)).to(nil) }
    end
  end
end
