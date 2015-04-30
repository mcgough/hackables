class TagsController < ApplicationController

  def index
    @tags = Tag.all
    @guides = Guide.all
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.create(tag_params)
    redirect_to @tag
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def update
    # @tag = Tag.find(params[:id])
    @tag = Tag.update(params[:id], tag_params)
    redirect_to @tag
  end

private

  def tag_params
    params.require(:tag).permit(:name)
  end



end