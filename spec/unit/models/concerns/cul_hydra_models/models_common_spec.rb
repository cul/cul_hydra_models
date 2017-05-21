require 'rails_helper'

describe "CulHydraModels::Common", type: :unit do

  context "predicates.yml file" do
    it "is present, and predicates are loaded and available to use in relationships" do
      cagg = ContentAggregator.new(pid: 'bat:man')

      expect { cagg.add_relationship(:fake_predicate, 'http://library.columbia.com/some/uri/value') }.to raise_error(ActiveFedora::UnregisteredPredicateError)
      expect { cagg.add_relationship(:cul_member_of, 'http://library.columbia.com/some/uri/value')}.not_to raise_error
    end
  end

  describe ".label= " do
    it "should truncate labels that are longer than 255 characters to 255 characters" do
      test_obj = ContentAggregator.new
      long_label =  "This is a very long label with a lot of words in it, but every single one " +
                    "of these words is essential and should remain here for the rest of time because " +
                    "future people from future generations will one day look back and admire the verbosity " +
                    "and it will profoundly affect them in ways that people from our own time are unlikely to understand."
      test_obj.label = long_label
      expect(test_obj.label).to_not eq(long_label)
      expect(test_obj.label.length).to_not eq(long_label.length)
      expect(test_obj.label.length).to eq(255)
    end
    it "should not truncate labels that are shorter than 255 characters" do
      test_obj = ContentAggregator.new
      short_label = 'Short label'
      test_obj.label = short_label
      expect(test_obj.label).to eq(short_label)
    end
    it "should also handle an array value (because the original method did) and use the first element" do
      test_obj = ContentAggregator.new
      short_label = ['Short label']
      test_obj.label = short_label
      expect(test_obj.label).to eq(short_label.first)
    end
  end

end
