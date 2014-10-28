class ApiController < ApplicationController
  require 'open-uri'
  require 'date'

  def name
    @show = Show.where(name: params[:id])
    respond_to do |format|
      format.html
      format.xml  { render :xml => @show }
      format.json { render :json => @show }
    end
  end

  def new
    @show = Show.new
  end

  def create
    @show = Show.create(post_params)
    @show.updateShowFromTVDB
    redirect_to api_index_url
  end

  def index
    @shows = Show.all
  end

  def tvdbid
    @show = Show.where(tvdbId: params[:id])
    respond_to do |format|
      format.html
      format.xml  { render :xml => @show }
      format.json { render :json => @show }
    end
  end

  private

    def post_params
      params.require(:show).permit(:name, :tvdbId)
    end
end
