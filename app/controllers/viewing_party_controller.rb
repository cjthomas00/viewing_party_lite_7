class ViewingPartyController < ApplicationController
  def new
    if session[:user_id]
      @facade = ViewingPartyFacade.new(params)
    else
      redirect_to movie_path(params[:id])
      flash[:notice] = "You must be logged in and registered to view your dashboard"
    end
  end

  def create
    @facade = ViewingPartyFacade.new(params)
    viewing_party = ViewingParty.new(viewing_party_params)
    if viewing_party.save
      viewing_party.save
      host = User.find(params[:user_id])
      host.viewing_party_users.create!(viewing_party_id: viewing_party.id, host: true)

      params[:user_ids].each do |user_id|
        user = User.find(user_id)
        user.viewing_party_users.create!(viewing_party_id: viewing_party.id, host: false)
      end

      redirect_to user_path(host)
      flash[:notice] = "Successfully created viewing party."
    else
      flash[:notice] = viewing_party.errors.full_messages.to_sentence
      redirect_to new_user_movie_viewing_party_path
    end
  end

  
  private
  def viewing_party_params
    params.require(:viewing_party).permit(:duration, :movie_id, "party_date(1i)", "party_date(2i)", "party_date(3i)", "start_time(4i)", "start_time(5i)")
  end
end