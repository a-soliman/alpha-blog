class ArticlesController < ApplicationController
  def show
    @article = Article.find(params[:id])
    puts @article
  end
end