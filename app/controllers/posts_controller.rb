# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string
#

class PostsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :get_post, only: [:show, :edit, :destroy, :update]
  before_action only: [:edit, :update, :destroy] do
    owner @post
  end

  def index
    @posts = Post.all.includes(:categories)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_param)
    if @post.save
      flash[:notice] = 'Post Successfully Created'
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  def update
    if @post.update(post_param)
      flash[:notice] = 'Post Successfully Updated'
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def edit

  end

  def destroy
    @post.destroy
    flash[:notice] = 'Post Successfully Deleted'
    redirect_to posts_path
  end


  private

  def get_post
    @post = Post.friendly.find(params[:id])
  end

  def post_param
    params.require(:post).permit(:title, :description, category_ids: [])
  end

end
