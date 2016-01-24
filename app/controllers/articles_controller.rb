class ArticlesController < ApplicationController
	def show
		@article = Article.find(params[:id]);
	end
	def new

	end

	def create
		@article = Article.new(article_params)

		@article.save
		redirect_to @article
	end
	def count
		@count = Article.count
	end
	def search
		@articles = Array.new(0)
		if params.has_key?(:article)
			if params[:article].has_key?(:title) && params[:article][:title] != ""
				@articles = Article.where("lower(title) LIKE ?","%" + params[:article][:title].downcase + "%")
			elsif params[:article].has_key?(:text) && params[:article][:text] != ""
				@articles = Article.where("lower(text) LIKE ?","%" + params[:article][:text].downcase + "%")
			else
				@articles = Article.all
			end
		else
			@articles = Article.all
		end
	end
		
	private
		def article_params
			params.require(:article).permit(:title, :text)
		end
end
