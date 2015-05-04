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
    redirect_to tags_path
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

  # ADD DESTROY METHOD FOR DELETING A TAG

  def destroy
    @tag = Tag.find(params[:id])
      unless @tag.guides
        Tag.destroy(params[:id])
      else
        flash[:info] = "You removed the #{@tag.name} tag from #{@tag.guides.length} " + "guide".pluralize(@tag.guides.length) + "."
        @tag.guides do |guide|
          guide.tags.delete(params[:id])
      end
      Tag.destroy(params[:id])
    end

    redirect_to tags_path
  end

private

  def tag_params
    params.require(:tag).permit(:name)
  end



end