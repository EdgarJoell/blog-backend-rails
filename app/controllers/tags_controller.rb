class TagsController < ApplicationController
  def index
    @tags = Tag.all
    render json: @tags, status: :ok
  end

  def show
    @tag = Tag.find_by(id: params[:id])

    return render json: { error: "Tag not found." }, status: :not_found if @tag.nil?

    render json: @tag, status: :ok
  end

  def create
    @tag = Tag.new(post_params)

    if @tag.save
      render json: @tag, status: :created
    else
      render json: { error: "Tag could not be created." }, status: :bad_request
    end
  end

  def update
    @tag = Tag.find_by(id: params[:id])

    return render json: { error: "Tag not found." }, status: :not_found if @tag.nil?

    if @tag.update(post_params)
      render json: @tag, status: :ok
    else
      render json: { error: "Tag could not be updated." }, status: :bad_request
    end
  end

  def destroy
    @tag = Tag.find_by(id: params[:id])

    return render json: { error: "Tag not found." }, status: :not_found if @tag.nil?

    if @tag.destroy
      head :ok
    end

    render json: { error: "Tag could not be destroyed." }, status: :internal_server_error
  end

  private
  def post_params
    params.require(:tag).permit(:name, :color)
  end
end
