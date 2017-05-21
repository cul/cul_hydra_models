require 'active-fedora'
class ContentAggregator < ActiveFedora::Base
  include CulHydraModels::Common

  # Uncomment the following lines to add an #attachment method that is a
  #   file_datastream:
  #
  # has_file_datastream "attachment"

  # "If you need to add additional attributes to the SOLR document, define the
  # #to_solr method and make sure to use super"
  #
  # def to_solr(solr_document={}, options={})
  #   super(solr_document, options)
  #   solr_document["my_attribute_s"] = my_attribute
  #   return solr_document
  # end

end
