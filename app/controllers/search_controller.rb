class SearchController < ApplicationController
	def search
		if params[:q].nil?
			@articles = Article.all
		else
			byebug
			results = Article.search(params[:q])
			@articles = results
		end
	end
end
