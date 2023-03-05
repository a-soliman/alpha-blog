class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update]
  before_action :require_admin, only: [:new, :create, :edit, :update]

  def index
    @categories = Category.paginate(page: params[:page]).order('created_at DESC')
  end

  def new
    @category = Category.new
  end

  def show
    @articles = @category.articles.paginate(page: params[:page]).order('created_at ASC')
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category #{@category.name.capitalize}, was created successfully."
      redirect_to @category
    else
      render 'new', status: :bad_request
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "Category #{@category.name.capitalize}, was updated successfully."
      redirect_to @category
    else
      render 'edit', status: :bad_request
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

end