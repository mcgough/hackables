class ContentsController < ApplicationController

def create
    @guide = Guide.find_by_id(params[:guide_id])
    @content = @guie.contents.create(content_params)
    # current_user.contents << @content

    if @content.save
      flash[:success] = "Content added!"
    end
    redirect_to @guide
  end

private
  def content_params
    params.require(:content).permit(:value)
  end

end