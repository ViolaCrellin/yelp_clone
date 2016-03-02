require 'rails_helper.rb'

feature 'reviewing' do
	before {Restaurant.create name:'KFC'}

	scenario 'allows users to leave a review using a form' do
		visit '/restaurants'
		click_link 'Review KFC'
		fill_in 'Thoughts', with: 'so so'
		select '3', from: 'Rating'
		click_button 'Leave Review'

		expect(current_path).to eq '/restaurants'
		expect(page).to have_content 'so so'
	end

	scenario 'allows users to delete their own reviews' do
		sign_up_and_in
		visit '/restaurants'
		click_link 'Review KFC'
		fill_in 'Thoughts', with: 'so so'
		select '3', from: 'Rating'
		click_button 'Leave Review'

		expect(current_path).to eq '/restaurants'
		expect(page).to have_content 'so so'
	end
end
