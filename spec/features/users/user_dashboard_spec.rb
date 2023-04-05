require "rails_helper"

describe "when I visit the user dashboard page" do
  describe "i should see" do
    before :each do
      VCR.use_cassette("godfather_5") do
        @user = create(:user)
        @user2 = create(:user)
        @user3 = create(:user)

        visit '/'
        click_on "Log In"

        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password

        click_on 'Log In'

        @vp1 = ViewingParty.create!({duration: 180, party_date: Date.new(2011, 1, 1,), start_time: '21:00', movie_id: 238})
        @vp2 = ViewingParty.create!({duration: 183, party_date: Date.new(2011, 2, 1,), start_time: '21:00', movie_id: 239})
        @vp3 = ViewingParty.create!({duration: 190, party_date: Date.new(2011, 3, 1,), start_time: '21:00', movie_id: 550})
        ViewingPartyUser.create!(user_id: @user.id, viewing_party_id: @vp1.id, host: true)
        ViewingPartyUser.create!(user_id: @user2.id, viewing_party_id: @vp1.id, host: false)
        ViewingPartyUser.create!(user_id: @user.id, viewing_party_id: @vp2.id, host: false)
        ViewingPartyUser.create!(user_id: @user3.id, viewing_party_id: @vp2.id, host: true)
        visit user_path(@user)
      end
    end

    it "<user's name>'s Dashboard at the top of the page" do
      expect(page).to have_content("#{@user.name}'s Dashboard")
    end

    it "a button to discover movies" do
      expect(page).to have_button("Discover Movies")

      click_button "Discover Movies"

      expect(page).to have_current_path("/users/#{@user.id}/discover")
    end

    it "a section that lists hosted parties" do
      within "#hosted-parties" do
        expect(page).to have_content(@vp1.start_time.strftime("%l:%M%P"))
        expect(page).to have_content(@vp2.start_time.strftime("%l:%M%P"))
        expect(page).to have_content(@vp3.start_time.strftime("%l:%M%P"))
        expect(page).to have_content(@vp1.party_date.strftime("%A, %B %d, %Y"))
      end
    end

    it "an image of the movie" do
      within "#party-#{@vp1.id}" do
        expect(page).to have_xpath("/html/body/div[2]/div")
      end
    end

    it "a Link to title of the movie" do
      within "#party-#{@vp1.id}" do
        expect(page).to have_link('The Godfather')
      end
    end

    it "date and time of event" do
      within "#party-#{@vp1.id}" do
      expect(page).to have_content(@vp1.party_date.strftime("%A, %B %d, %Y"))
      expect(page).to have_content(@vp1.start_time.strftime("%l:%M%P"))
      end
    end

    it "who is hosting the event" do
      within "#hosted-parties" do
        within "#party-#{@vp1.id}" do
        expect(page).to have_content(@user.name)
        end
      end
    end

    it "list of users invited with my name in bold" do
      within "#attended-parties" do
        within "#party-#{@vp2.id}" do
        expect(page).to have_content(@user.name)
        end
      end
    end

    it "a section that lists attended parties" do
      within "#attended-parties" do
        expect(page).to have_content(@vp2.start_time.strftime("%l:%M%P"))
        expect(page).to have_content(@vp2.start_time.strftime("%l:%M%P"))
        expect(page).to have_content(@vp2.party_date.strftime("%A, %B %d, %Y"))
      end
    end
  end
end