require 'elasticsearch/model'

class Article < ActiveRecord::Base
	include Searchable
end
Article.import force: true