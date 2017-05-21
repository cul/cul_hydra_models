require 'active-fedora'
module CulHydraModels
  module Common
    extend ActiveSupport::Concern

    included do
      extend ActiveModel::Callbacks
      has_metadata "descMetadata", type: Datastreams::ModsDocument, versionable: true
    end

    module ClassMethods
    end

    # A Fedora object label can only contain a string value of up to 255 characters.  If we try to
    # set a longer value, it causes errors upon object save.  Truncate labels to 255 characters.
    # Note: this method maps to a method_missing hanlder that converts input into a String, so
    # we use the super method first, and then post-process the output of that super method call.
    def label=(new_label)
      super(new_label)
      super(self.label[0, 255])
    end
  end
end
