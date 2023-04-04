class ViewingPartyFacade
  attr_reader :user, 
              :movie_id

  def initialize(params, viewing_party = nil)
    @user = User.find(params[:user_id])
    @movie_id = params[:movie_id]
    # @viewing_party = ViewingParty.find(params[:viewing_party_id]) if viewing_party.present?
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