require 'rails_helper.rb'

feature 'restaurants' do
	context 'no restaurants have been added' do
		scenario 'should desplay a prompt to add a restaurant' do
			visit '/restaurants'
			expect(page).to have_content 'No restaurant yet!'
			expect(page).to have_link 'Add a restaurant'
		end
	end

	context 'restaurants have been added' do
		before do
			Restaurant.create(name: 'KFC')
		end

		scenario 'display restaurants' do
			visit '/restaurants'
			expect(page).to have_content('KFC')
			expect(page).not_to have_content('No restaurant yet!')
		end
	end

	context 'creating restaurants' do

		before do
			sign_up_and_in('me@meemail.com', 'passwordy')
		end

		scenario 'prompts user to fill out a form, then displays the new restaurant' do
			add_restaurant_KFC
			expect(page).to have_content 'KFC'
			expect(current_path).to eq '/restaurants'
		end

		scenario "can upload a picture" do
		  add_restaurant_KFC
			expect(page).to have_selector("img")
		end

		context 'an invalid restaurant' do

	    it 'does not let you submit a name that is too short' do
	      visit '/restaurants'
	      click_link 'Add a restaurant'
	      fill_in 'Name', with: 'kf'
	      click_button 'Create Restaurant'
	      expect(page).not_to have_css 'h2', text: 'kf'
	      expect(page).to have_content 'error'
	    end

			it "is not valid unless it has a unique name" do
	  		Restaurant.create(name: "Moe's Tavern")
	  		restaurant = Restaurant.new(name: "Moe's Tavern")
	  		expect(restaurant).to have(1).error_on(:name)
			end
		end
	end

	context 'viewing restaurants' do

	let!(:kfc){Restaurant.create(name:'KFC')}

	  scenario 'lets a user view a restaurant' do
	   visit '/restaurants'
	   click_link 'KFC'
	   expect(page).to have_content 'KFC'
	   expect(current_path).to eq "/restaurants/#{kfc.id}"
	  end
	end

	context 'editing restaurants' do

		before do
			sign_up_and_in('me@meemail.com', 'passwordy')
			add_restaurant_KFC
		end

		scenario 'let user edit a restaurant' do
			visit '/restaurants'
			click_link 'Edit KFC'
			fill_in 'Name', with: 'Kentucky Fried Chicken'
			click_button 'Update Restaurant'
			expect(page).to have_content 'Kentucky Fried Chicken'
			expect(current_path).to eq '/restaurants'
		end
	end

	context 'deleting restaurants' do

		before do
			sign_up_and_in('me@meemail.com', 'passwordy')
			add_restaurant_KFC
		end

	  scenario 'removes a restaurant when a user clicks a delete link' do
	    visit '/restaurants'
	    click_link 'Delete KFC'
	    expect(page).not_to have_content 'KFC'
	    expect(page).to have_content 'Restaurant deleted successfully'
			expect(current_path).to eq '/restaurants'
	  end

	end

	context 'user authentification requirements' do

		before do
			Restaurant.create name:'KFC'
		end

		scenario 'prompting the user to sign in before they can edit a restaurant' do
			visit '/restaurants'
			click_link 'Edit KFC'
			expect(page).to have_content 'You need to sign in or sign up before continuing'
			expect(page).not_to have_content 'Update Restaurant'
			expect(current_path).to eq '/users/sign_in'
		end

		scenario 'only allowing users to delete their own restaurants' do
	    visit '/restaurants'
	    click_link 'Delete KFC'
			expect(page).to have_content 'You need to sign in or sign up before continuing'
	    expect(page).not_to have_content 'Restaurant deleted successfully'
			expect(current_path).to eq '/users/sign_in'
	  end
	end
end
