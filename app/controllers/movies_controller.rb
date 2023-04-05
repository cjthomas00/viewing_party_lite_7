class MoviesController < ApplicationController
  def discover
    @user = current_user
  end

  def index
    movie_title = params[:movie_title]
    @facade = MoviesFacade.new(movie_title, current_user)
    if @facade.empty_request?
      redirect_to discover_user_path
      flash[:notice] = "No movie results found for '#{@facade.movie_results}'"
    end
  end

  def show
    @facade = MovieFacade.new(params[:id], current_user)
  end
end










