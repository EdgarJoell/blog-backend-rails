class PostsController < ApplicationController
  def index
    @posts = Post.all
    render json: @posts
  end

  def show
    @post = Post.find(params[:id])
    render json: @post
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post, status: 201
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post
      @post.update(post_params)
      render json: @post, status: 201
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post
      @post.destroy
    end
  end

  def latest_posts
     @posts = Post.where(is_latest: true)
     if @posts
       render json: @posts
     else
       render json: @posts.errors, status: :unprocessable_entity
     end
  end

  private

  def post_params
    params.require(:post).permit(:title, :author, :is_latest, :published, :content)
  end
end
