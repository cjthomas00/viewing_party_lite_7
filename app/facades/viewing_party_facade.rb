class ViewingPartyFacade
  attr_reader :user, 
              :movie_id

  def initialize(user, params, viewing_party = nil)
    @user = user
    @movie_id = params[:movie_id]
  end

  def service
    MoviedbService.new
  end

  def movie
    json = service.movie(@movie_id)
    Movie.new(json)
  end

  def new_viewing_party
    @user.viewing_parties.new
  end

  def users
    User.where("id != #{@user.id}")
  end
end