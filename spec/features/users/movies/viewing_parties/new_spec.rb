require 'rails_helper'

describe "When I visit the new viewing party page (/users/:user_id/movies/:movid_id/viewing-party/new, where :user_id is a valid user's id)" do
  before :each do
    @user = create(:user)
    @user2 = create(:user)
    @user3= create(:user)
    @user4 = create(:user)
    @user5 = create(:user)
    @user6 = create(:user)
    @user7 = create(:user)
    @user8 = create(:user)

    visit '/'
    click_on "Log In"

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password

    click_on 'Log In'
    
    VCR.use_cassette('viewing_party_2') do
      facade = MovieFacade.new({id: 238, user_id: @user.id})
      @movie = facade.movie
      visit new_user_movie_viewing_party_path(@user, @movie.id)
    end

  end

  describe 'form' do
    it 'has a field for duration of party with a default value of movie runtime in minutes' do
      expect(page).to have_field("viewing_party[duration]", with: @movie.runtime)
    end

    it "has a field to select the date" do
      expect(page).to have_field('viewing_party[party_date(1i)]')
      expect(page).to have_field('viewing_party[party_date(2i)]')
      expect(page).to have_field('viewing_party[party_date(3i)]')
    end

    it "has a field to select the start time" do
      expect(page).to have_field('viewing_party[start_time(4i)]')
      expect(page).to have_field('viewing_party[start_time(5i)]')
    end

    it "has checkboxes next to each existing user in the system" do
      expect(page).to have_unchecked_field('user_ids[]', count: 7)
    end

    it "has a button to create a party" do
      expect(page).to have_button("Create Viewing Party")
    end

  end

  describe 'details' do
    before :each do
      within "##{@user2.id}" do
        check 'user_ids[]'
      end

      within "##{@user4.id}" do
        check 'user_ids[]'
      end

      within "##{@user7.id}" do
        check 'user_ids[]'
      end

      within "##{@user8.id}" do
        check 'user_ids[]'
      end
    end

    it "reroutes the user back to their dashboard where the party is shown after the create" do
      VCR.use_cassette('viewing_party_3') do
        click_button 'Create Viewing Party'
      end

      expect(page).to have_current_path(user_path(@user))


      within "#hosted-parties" do
        expect(page).to have_content(@movie.title)
      end
    end

    it 'will validate that the viewing party length is greater than or equal to the duration of the movie' do
      fill_in 'Duration', with: '120'
      select 'April', from: 'viewing_party[party_date(2i)]'
      select 3, from: 'viewing_party[party_date(3i)]'

      select 20, from: 'viewing_party[start_time(4i)]'
      select 15, from: 'viewing_party[start_time(5i)]'
      
      VCR.use_cassette('viewing_party_2') do
        click_button 'Create Viewing Party'
      end


      expect(page).to have_current_path(new_user_movie_viewing_party_path(@user, @movie.id))
      expect(page).to have_content('Duration must be greater than or equal to movie runtime: 175 minutes')
    end

    
      
    it "is listed in other user's dashboards that were invited to the party" do
      select 'April', from: 'viewing_party[party_date(2i)]'
      select 3, from: 'viewing_party[party_date(3i)]'

      select 20, from: 'viewing_party[start_time(4i)]'
      select 15, from: 'viewing_party[start_time(5i)]'

      VCR.use_cassette('viewing_party_4') do
        click_button 'Create Viewing Party'
      end
      
      expect(page).to have_current_path(user_path(@user))  

      visit user_path(@user2)

      expect(page).to have_content('The Godfather Viewing Party on March 25th, 2023')
    end
  end

  describe 'sad_path for form submission' do
    
  end
end
