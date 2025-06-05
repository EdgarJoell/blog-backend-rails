class AuthorsController < ApplicationController
  def index
    @authors = Author.all
    render json: @authors, status: 200
  end

  def show
    begin
      @author = Author.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "No record with this ID was found." }, status: :not_found
    end

    render json: @author, status: 200
  end

  def create
    @author = Author.new(post_params)

    unless @author.save
      render json: @author.errors, status: :unprocessable_content
    end

    render json: @author, status: 201
  end

  def update
    begin
      @author = Author.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { message: "There was no record found with this ID" }, status: 404
    end

    unless @author.update(post_params)
      render json: @author.errors, status: :unprocessable_entity
    end

    render json: @author, status: 200
  end

  def destroy
    begin
      @author = Author.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { message: "There was no record found with this ID" }, status: 404
    end

    if @author.destroy
      render status: 204
    else
      render json: { error: "Could not delete the record. Please try again soon." }, status: :unprocessable_entity
    end
  end

  private
  def post_params
    params.require(:author).permit(:first_name, :last_name, :email)
  end
end
