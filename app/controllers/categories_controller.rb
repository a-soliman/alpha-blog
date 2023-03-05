class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]
  before_action :require_admin, only: [:new, :create]

  def index
    @categories = Category.paginate(page: params[:page]).order('created_at DESC')
  end

  def new
    @category = Category.new
  end

  def show
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category #{@category.name}, was created successfully."
      redirect_to @category
    else
      render 'new', status: :bad_request
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