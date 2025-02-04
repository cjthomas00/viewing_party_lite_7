require "rails_helper"

RSpec.describe "Details Page", type: :feature do
  describe "When I visit a movie's detail page (/users/:user_id/movies/:movie_id where :id is a valid user id,I should see" do
    before :each do
      @user = create(:user)
    #   attrs = {
    #   id: 238,
    #   title: "The Godfather",
    #   vote_average: 8.7,
    #   runtime: 175,
    #   genres: [
    #   {
    #       "id": 18,
    #       "name": "Drama"
    #   },
    #   {
    #       "id": 80,
    #       "name": "Crime"
    #   }
    #   ],
    #   overview: "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge."
    # }
    #   @movie = Movie.new(attrs)
      # require 'pry'; binding.pry
      VCR.use_cassette("godfather_movie_2") do
        visit user_movie_path(@user, 238)
      end
    end
    it "A Button to create a viewing party" do
      expect(page).to have_button("Create Viewing Party")
    end

    it "Has a Button to return to the Discover page" do
      expect(page).to have_button("Return to Discover Page")
    end

    it "shows the title of the movie" do
      within "#movie-info" do
        expect(page).to have_content("The Godfather")
      end
    end

    it "shows the vote average of the movie" do
      within "#movie-info" do
        expect(page).to have_content(8.7)
      end
    end

    it "shows the runtime in hours and minutes" do
      within "#movie-info" do
        expect(page).to have_content("2 hours and 55 minutes")
      end
    end

    it "shows the genres of the movie" do
      within "#movie-info" do
        expect(page).to have_content(["Drama", "Crime"])
      end
    end

    it "shows the summary description of the movie" do
      within "#movie-info" do
        expect(page).to have_content("Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.")
      end
    end

    it "shows the first 10 cast members of the movie" do
      within "#cast-info" do
        expect(page).to have_content("Cast:")
        expect(page).to have_content("Starring: Marlon Brando")
        expect(page).to have_content("as: Don Vito Corleone")
      end
    end
    
    it "shows the count of total reviews of the movie" do
      within "#movie-info" do
        expect(page).to have_content("Movie Review Count: 2")
      end
    end

    it "shows each review's author and information" do
      within "#movie-info" do
        expect(page).to have_content("Author: futuretv")
        expect(page).to have_content("Review: The Godfather Review by Al Carlson")
        expect(page).to have_content("Created at: 2014-04-10T20:09:40.500Z")
        expect(page).to have_content("Author: crastana")
      end
    end
  end
end