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
  @tags = Tag.all

  @guide_tags = ""

  @guide.tags.each do |x|
    @guide_tags = @guide_tags + " " + x.name
  end

  # p @guide.title
  # p @guide_tags

  # p "#{@guide_tags} learn"

  request = Typhoeus::Request.new(
    "www.reddit.com/search.json",
    method: :get,
    params: {q: "learn #{@guide_tags}"}
    )

  response = request.run
  data = JSON.parse(response.body)

  @titles = data["data"]["children"].map {|e| e["data"]["title"].to_s}
  @urls = data["data"]["children"].map {|e| e["data"]["url"].to_s}
  # @photos = data["data"]["children"].map {|e| e["data"]["thumbnail"]}

  # p @photos
  # @urls = data["data"]["children"].map {|e| {name: e["data"]["url"].to_s, thing: "blah"}}

  @title_urls = {}
  Hash[@titles.zip(@urls).each {|a,b| @title_urls[a] = b }]

  # p @title_urls
  # p @titles
  # p @urls

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

def destroy
  @guide = Guide.find(params[:id])
  Guide.destroy(params[:id])
  redirect_to guides_path
end

private

def guide_params
  params.require(:guide).permit(:title,:description)
end

end
