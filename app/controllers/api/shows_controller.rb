module Api
  class ShowsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :sync
    before_action :logged_in_user, only: [:new, :create, :update_all]

    def index
      respond_to do |format|
        format.html do
          @user = logged_in? ? {state: 'out', method: 'delete'} : {state: 'in', method: 'get'}
          @shows = Show.all.order(:name)
        end
        format.json do
          shows = Show.select("name, tvdbId")
          render :json => shows.to_json(only: [ :name, :tvdbId ]) 
        end
      end
    end

    def new
      @show = Show.new
    end

    def create
      show = Show.create(post_params)
      show.update_from_tvdb
      ShowLog.create(log: "Added Show: #{params[:show][:name]}")
      flash[:info] = "Added #{show.name} to the database."
      redirect_to api_shows_path
    end

    def update_all
      shows = Show.all
      shows.each { |show| show.update_from_tvdb }
      flash[:info] = "All shows were updated"
      redirect_to api_shows_path
    end
    
    # last_updated checks if master show lists are in sync
    def last_updated
      updated = ShowLog.select(:id, :created_at).last
      render json: updated
    end

    # Sync recieves a POST from the app of all shows being followed, tvdbid retrieves each show
    def sync
      results = []
      params[:shows].each do |k, v|
        show = Show.find_by_tvdbId(k) # This is innefficient at the moment
        results << k.to_i unless show.updated_at.to_i == v.to_i
      end
      render json: results.to_json   
    end

    def tvdbid
      show = Show.find_by_tvdbId(params[:id])
      respond_to do |format|
        format.json { render json: show, root: false }
      end
    end

    private

    def post_params
      params.require(:show).permit(:name, :tvdbId)
    end

  end
end