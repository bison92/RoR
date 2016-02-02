require 'elasticsearch/model'

class Article < ActiveRecord::Base
	include Searchable
	validates :title, presence: true,
					  length: { minimum: 5 }
end
# Delete the previous articles index in Elasticsearch
Article.__elasticsearch__.client.indices.delete index: Article.index_name rescue nil

# Create the new index with the new mapping
Article.__elasticsearch__.client.indices.create \
  index: Article.index_name,
  body: { settings: Article.settings.to_hash, mappings: Article.mappings.to_hash }

# Index all article records from the DB to Elasticsearch
Article.import force: true