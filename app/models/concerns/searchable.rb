module Searchable extend ActiveSupport::Concern

	included do
		include Elasticsearch::Model

#		mapping do
			#...
#		end
		settings index: { number_of_shards: 1 } do
		  mappings dynamic: 'false' do
		    indexes :title, analyzer: 'english', index_options: 'offsets'
		    indexes :text, analyzer: 'english'
		  end
		end

		def self.search(query)
		  __elasticsearch__.search(
		    {
		      query:{
			       multi_match: {
				    query:      query,
				    type:       "phrase_prefix",
				    fields:     [ "title", "text" ]
				}
		      },
		      highlight: {
		        pre_tags: ['<em>'],
		        post_tags: ['</em>'],
		        fields: {
		          title: {},
		          text: {}
		        }
		      }
		    }
		  )
		end
	end
end