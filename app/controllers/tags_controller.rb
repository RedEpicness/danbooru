class TagsController < ApplicationController
  respond_to :html, :xml, :json

  def edit
    @tag = authorize Tag.find(params[:id])
    respond_with(@tag)
  end

  def index
    @tags = authorize Tag.paginated_search(params, hide_empty: true)
    @tags = @tags.includes(:consequent_aliases) if request.format.html?
    respond_with(@tags)
  end

  def show
    @tag = authorize Tag.find(params[:id])
    respond_with(@tag)
  end

  def update
    @tag = authorize Tag.find(params[:id])
    @tag.update(permitted_attributes(@tag))
    respond_with(@tag)
  end
end
