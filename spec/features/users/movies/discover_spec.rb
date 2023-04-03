require "rails_helper"

describe "When I visit the '/users/:id/discover' path, where :id, is the id of a valid user" do
  before :each do
    @user = create(:user, password: "password1", password_confirmation: "password1")

    visit user_movies_discover_path(@user)
  end

  describe "i should see" do
    it "a button to discover top rated movies" do
      expect(page).to have_button("Discover Top Rated Movies")
    end

    it "a text field to enter keywords to search by movie title" do
      within "#search" do
        expect(page).to have_field("movie_title")
      end
    end

    it "a button to search by movie title" do
      within "#search" do
        expect(page).to have_button("Search by Movie Title")
      end
    end
  end

  describe "details" do
    it "When the user clicks on the Top Rated Movies, they should be taken to the movies results page" do
      VCR.use_cassette("top_rated_movies") do
        click_button "Discover Top Rated Movies"
      end

      expect(page).to have_current_path("/users/#{@user.id}/movies")
    end

    it "When the user clicks on the search button, they should be taken to the movies results page" do
      within "#search" do
        VCR.use_cassette("search_results") do
          fill_in "movie_title", with: "Despicable"
          click_button "Search by Movie Title"
        end

        expect(page.current_path).to eq("/users/#{@user.id}/movies")
      end
    end

    it "if the user puts in a non-existent keyword, they should get a flash message and the discover page" do
      within "#search" do
        VCR.use_cassette("nil_search_results") do
          fill_in "movie_title", with: "tobacco and worms for breakfast"
          click_button "Search by Movie Title"
        end
        
        expect(page).to have_current_path(user_movies_discover_path(@user))
      end
      expect(page).to have_content("No movie results found for 'tobacco and worms for breakfast'")
    end
  end
end