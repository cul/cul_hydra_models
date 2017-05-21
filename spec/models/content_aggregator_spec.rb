require 'rails_helper'
require 'active_fedora/test_support'

describe ContentAggregator do
  it_behaves_like 'An ActiveModel'
  include ActiveFedora::TestSupport
  subject { ContentAggregator.new }

  describe "when persisted to fedora" do
    before { subject.save! }
    after { subject.destroy }
    it 'should exist' do
      expect(ContentAggregator.exists?(subject.pid)).to be_truthy
    end
  end

  it 'should have a descMetadata datastream' do
    expect(subject.descMetadata).to be_a(Datastreams::ModsDocument)
  end

end
