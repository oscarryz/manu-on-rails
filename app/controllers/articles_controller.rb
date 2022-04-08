class ArticlesController < ApplicationController
  def index
    @articles = Article.all
    FetchArticlesJob.perform_now
  end

  def show
    @article = Article.find(params[:id])
  end

end
