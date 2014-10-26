class ApiController < ApplicationController
  def name
    @show = Show.where(name: params[:id])
    respond_to do |format|
      format.html
      format.xml  { render :xml => @show }
      format.json { render :json => @show }
    end
  end

  def tvdbid
    @show = Show.where(tvdbId: params[:id])
    respond_to do |format|
      format.html
      format.xml  { render :xml => @show }
      format.json { render :json => @show }
    end
  end
end
