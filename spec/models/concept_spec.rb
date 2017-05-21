require 'rails_helper'
require 'active_fedora/test_support'

describe Concept do
  it_behaves_like 'An ActiveModel'
  include ActiveFedora::TestSupport
  subject { Concept.new }

  describe "when persisted to fedora" do
    before { subject.save! }
    after { subject.destroy }
    it 'should exist' do
      expect(Concept.exists?(subject.pid)).to be_truthy
    end
    it 'should cast properly when retrieved' do
      expect(ActiveFedora::Base.find(subject.pid)).to be_a(Concept)
    end
  end

  it 'should have a descMetadata datastream' do
    expect(subject.descMetadata).to be_a(Datastreams::ModsDocument)
  end

end
