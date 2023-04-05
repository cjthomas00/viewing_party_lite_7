class ViewingPartyController < ApplicationController
  def new
    if current_user == nil 
      flash[:error] = "Please login or register to create a viewing party."
      redirect_to root_path
    else
      @facade = ViewingPartyFacade.new(current_user, params)
    end
  end

  def create
    @facade = ViewingPartyFacade.new(current_user, params)
    viewing_party = ViewingParty.new(viewing_party_params)
    if viewing_party.save
      viewing_party.save
      host = current_user
      host.viewing_party_users.create!(viewing_party_id: viewing_party.id, host: true)

      params[:user_ids].each do |user_id|
        user = User.find(user_id)
        user.viewing_party_users.create!(viewing_party_id: viewing_party.id, host: false)
      end

      redirect_to user_path
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