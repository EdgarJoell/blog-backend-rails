class PostsController < ApplicationController
  def index
    @posts = Post.all
    render json: @posts, status: 200
  end

  def show
    @post = Post.find_by(id: params[:id])

    return render json: { error: "Post not found" }, status: 404 if @post.nil?

    render json: @post, status: 200
  end

  def create
    tag_ids = params[:post][:tags].map(&:to_i).uniq
    @post = Post.new(post_params.except(:tags))

    if @post.save
      tags = Tag.where(id: tag_ids)

      if tags.size != tag_ids.size
        return render json: { error: "One or more tag IDs are invalid" }, status: :unprocessable_entity
      end

      @post.tags = tags
      render json: @post, include: :tags, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
    @post = Post.find_by(id: params[:id])

    return render json: { error: "Could not find a record with this ID" }, status: 404 if @post.nil?

    if @post.update(post_params)
      render json: @post, status: 201
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])

    return render json: { error: "Could not find a record with this ID" }, status: 404 if @post.nil?

    if @post.destroy
      head 204
    else
      render json: { error: "Could not delete the record. Please try again soon." }, status: :unprocessable_entity
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
    params.require(:post).permit(:title, :is_latest, :published, :content, :author_id, tags: [])
  end
end
