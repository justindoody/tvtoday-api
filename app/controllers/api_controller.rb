class ApiController < ApplicationController
  require 'open-uri'
  require 'date'

  def name
    @show = Show.where(name: params[:id]).first
    respond_to do |format|
      format.html
      format.xml  { render :xml => @show }
      format.json { render :json => @show.to_json(:except => [ :id, :created_at ]) }
    end
  end

  def new
    @show = Show.new
  end

  def create
    @show = Show.create(post_params)
    @show.updateShowFromTVDB
    ShowLog.create(log: "Added Show: #{params[:show][:name]}")
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
      format.json { render :json => @show.to_json(:except => [ :id, :created_at ]) }
    end
  end

  def shows_json
    @show = Show.select("name, tvdbId").first
    respond_to do |format|
      format.html
      format.xml  { render :xml => @show }
      format.json { render :json => @show.to_json(:only => [ :name, :tvdbId ]) }
    end
  end

  def shows_updated
    @updated = ShowLog.select(:id, :created_at).last
    render json: @updated
  end

  private

    def post_params
      params.require(:show).permit(:name, :tvdbId)
    end
end
