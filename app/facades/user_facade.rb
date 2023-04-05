class UserFacade
  attr_reader :user

  def initialize(user, viewing_party = nil)
    @user = user
  end

  def service
    MoviedbService.new
  end

  def hosted_parties
    @user.hosted_parties
  end

  def attended_parties
    @user.attended_parties
  end
end