module Api
  class ShowsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :sync
    before_action :check_for_lockup, only: [:new, :create, :update_all]

    def index
      respond_to do |format|
        format.html do
          @shows = Show.all.order(:name)
        end

        format.json do
          shows = Rails.cache.fetch('all_shows') do
            Show.pluck(:name, :tvdbId).map do |show|
              {
                name: show.first,
                tvdbId: show.last
              }
            end
          end

          render json: shows.to_json(only: [ :name, :tvdbId ])
        end
      end
    end

    def new
      @show = Show.new
    end

    def create
      @show = Show.new(post_params)

      if @show.save
        Tvdb::Show.new(@show).find_latest_episodes

        flash[:info] = "Added #{@show.name} to the tracker."
        redirect_to api_shows_path
      else
        flash[:warning] = @show.errors.full_messages
        render :new
      end
    end

    def update_all
      # TODO: move to a background job
      Show.find_each do |show|
        Tvdb::Show.new(show).find_latest_episodes
      end

      flash[:info] = 'All shows were updated'
      redirect_to api_shows_path
    end

    # last_updated checks if master show lists are in sync
    def last_updated
      updated = Show.select(:id, :created_at).last.to_json
      render json: updated
    end

    # Sync recieves a POST from the app of all shows being followed, tvdbid retrieves each show
    def sync
      params = params.permit!.to_h
      shows = params[:shows]

      outdated_ids = Show.where(tvdbId: shows.keys).map do |show|
        show.tvdbId if show.outdated_data?(shows[show.tvdbId.to_s])
      end.compact

      # TODO: this really ought to just post back the necessary data to avoid a bunch of calls...
      render json: outdated_ids.to_json
    end

    def tvdbid
      # Rails.cache.delete("tvdbid/#{tvdbid_param}")
      show = Rails.cache.fetch("tvdbid/#{tvdbid_param}") do
        Show.find_by_tvdbId(tvdbid_param)
      end

      json = cache ['v1', show] do
        render_to_string json: show, root: false
      end

      render json: json
    end

    def search
      redirect_to "http://thetvdb.com/api/GetSeries.php?seriesname=#{search_query}"
    end

    private

      def post_params
        params.require(:show).permit(:name, :tvdbId)
      end

      def tvdbid_param
        params.require(:id)
      end

      def search_query
        params.require(:q)
      end

  end
end
