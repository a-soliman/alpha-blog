class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      flash[:notice] = "Article was created successfully."
      redirect_to articles_path
    else
      render 'new', status: :bad_request
    end
  end

  def edit

    if @article != nil 
      render 'edit'
    else
      flash[:alert] = "Trying to access non-existing article"
      redirect_to articles_path
    end
  end

  def update
    
    if @article.update(article_params)
      flash[:notice] = "Article was updated successfully."
      redirect_to articles_path
    else
      render 'edit', status: :bad_request
    end
  end

  def destroy
    if @article.destroy
      flash[:notice] = "Article was deleted successfully."
      redirect_to articles_path
    else 
      flash[:alert] = "Unable to delete article"
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end
end