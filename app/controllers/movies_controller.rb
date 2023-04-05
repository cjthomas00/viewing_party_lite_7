class MoviesController < ApplicationController
  def discover
    @user = User.find(params[:user_id])
  end

  def index
    @facade = MoviesFacade.new(params)
    if @facade.empty_request?
      redirect_to user_movies_discover_path(@facade.user)
      flash[:notice] = "No movie results found for '#{@facade.movie_results}'"
    end
  end

  def show
    @session_user = session[:user_id]
    @facade = MovieFacade.new(params)
  end
end
