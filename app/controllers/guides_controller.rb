class GuidesController < ApplicationController

  def index
    @guides = Guide.all
    @tags = Tag.all
  end

  def new
    @guide = Guide.new
    @tags = Tag.all
  end

  def create
    @guide = Guide.create(guide_params)
    tags = params[:guide][:tag_ids]

    tags.each do |tag_id|
      @guide.tags << Tag.find(tag_id) unless tag_id.blank?
    end
# render :json => params
    redirect_to @guide
  end

  def show
    @guide = Guide.find(params[:id])
  end

  def edit
    @guide = Guide.find(params[:id])
    @tags = Tag.all
  end

  def update
    @guide = Guide.update(params[:id], guide_params)

    @guide.tags.clear
    tags = params[:guide][:tag_ids]
    tags.each do |tag_id|
      @guide.tags << Tag.find(tag_id) unless tag_id.blank?
    end
    redirect_to @guide
  end


  private

    def guide_params
      params.require(:guide).permit(:title,:description)
    end

end
