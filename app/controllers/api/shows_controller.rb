module Api
  class ShowsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :sync
    before_action :logged_in_user, only: [:new, :create, :update_all]

    def index
      respond_to do |format|
        format.html do
          @shows = Show.all.order(:name)
        end
        format.json do
          shows = Rails.cache.fetch('all_shows') do
            Show.select('name, tvdbId').to_json(only: [ :name, :tvdbId ])
          end

          render json: shows
        end
      end
    end

    def new
      @show = Show.new
    end

    def create
      @show = Show.new(post_params)
      @show.update_from_tvdb

      if @show.save
        ShowLog.create(log: "Added Show: #{@show.name}")
        flash[:info] = "Added #{@show.name} to the tracker."
        redirect_to api_shows_path
      else
        flash[:warning] = @show.errors.full_messages
        render action: :new
      end
    end

    def update_all
      Show.find_each(&:update_from_tvdb)

      flash[:info] = 'All shows were updated'
      redirect_to api_shows_path
    end

    # last_updated checks if master show lists are in sync
    def last_updated
      updated = ShowLog.select(:id, :created_at).last
      render json: updated
    end

    # Sync recieves a POST from the app of all shows being followed, tvdbid retrieves each show
    def sync
      shows = params[:shows]

      outdated_ids = Show.where(tvdbId: shows.keys).map do |show|
        show.tvdbId if show.outdated_data?(shows[show.tvdbId.to_s])
      end.compact

      # this really ought to just post back the necessary data to avoid a bunch of calls...
      render json: outdated_ids.to_json
    end

    def tvdbid
      tvdbid = params[:id]
      show = Rails.cache.fetch("tvdbid/#{tvdbid}") do
        Show.find_by_tvdbId(tvdbid)
      end

      json = cache ['v1', show] do
        render_to_string json: show, root: false
      end

      render json: json
    end

    private

    def post_params
      params.require(:show).permit(:name, :tvdbId)
    end
  end
end
