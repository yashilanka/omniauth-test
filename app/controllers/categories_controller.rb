# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#

class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :get_category, only: [:edit, :show, :update, :destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(set_params)
    if @category.save
      flash[:success] = 'Category Successfully Created'
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @category.update(set_params)
      flash[:success] = 'Category Successfully Updated'
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    flash[:notice] = 'Category Successfully Deleted'
    redirect_to categories_path
  end


  private

  def get_category
    @category = Category.friendly.find(params[:id])
  end

  def set_params
    params.require(:category).permit(:name)
  end
end
