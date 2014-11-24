class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :sync
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
    @shows = Show.all.order(:name)
    # Laughable security I know. Not important in this instance though.
    if params[:id] == "admin"
      @admin = true
    end
  end

  def tvdbid
    @show = Show.find_by_tvdbId(params[:id])
    respond_to do |format|
      format.html
      format.xml  { render :xml => @show }
      #format.json { render :json => @show.to_json(:except => [ :id, :created_at ]) }
      format.json { render json: @show, root: false }
    end
  end

  def shows_json
    @show = Show.select("name, tvdbId")
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

  def update_shows
    shows = Show.all
    shows.each do |show|
      show.updateShowFromTVDB
    end
  end

  def sync
    results = []
    params[:shows].each do |k, v|
      show = Show.find_by_tvdbId(k)
      if show.updated_at.to_i != v.to_i
        results << k.to_i
      end
    end
    render json: results.to_json   
  end

  private

    def post_params
      params.require(:show).permit(:name, :tvdbId)
    end
end
