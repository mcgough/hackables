class GuidesController < ApplicationController

  def index
    @guides = Guide.all
  end

  def new
    @guide = Guide.new
  end

  def create
    @guide = Guide.create(guide_params)
    redirect_to @guide
  end

  def show
    @guide = Guide.find(params[:id])
  end

  private

    def guide_params
      params.require(:guide).permit(:title,:description)
    end

end
