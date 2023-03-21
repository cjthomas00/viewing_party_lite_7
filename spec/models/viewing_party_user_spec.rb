require "rails_helper"

describe ViewingPartyUser, type: :model do
  describe "relationship" do
    it { should belong_to :user}
    it { should belong_to :viewing_party}
  end
end