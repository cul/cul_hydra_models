require 'rails_helper'
require 'active_fedora/test_support'

describe Collection do
  it_behaves_like 'An ActiveModel'
  include ActiveFedora::TestSupport
  subject { Collection.new }

  describe "when persisted to fedora" do
    before { subject.save! }
    after { subject.destroy }
    it 'should exist' do
      expect(Collection.exists?(subject.pid)).to be_truthy
    end
    it 'should cast properly when retrieved' do
      expect(ActiveFedora::Base.find(subject.pid)).to be_a(Collection)
    end
  end

  it 'should have a descMetadata datastream' do
    expect(subject.descMetadata).to be_a(Datastreams::ModsDocument)
  end
end
