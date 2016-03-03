require 'rails_helper'

feature 'reviewing' do
	before {Restaurant.create name:'KFC'}

	scenario 'only allows logged in users to leave a review' do
		visit '/restaurants'
		click_link 'Review KFC'
		expect(current_path).to eq '/users/sign_in'
		expect(page).to have_content 'You need to sign in or sign up before continuing'
	end

	scenario 'allows signed in users to leave reviews' do
		sign_up_and_in('test@test.com', 'thisisapassword')
		leave_review_KFC('so so', 3)
		expect(current_path).to eq '/restaurants'
		expect(page).to have_content 'so so'
	end

	scenario 'signed in users can only leave one review per restaurant' do
		sign_up_and_in('test@test.com', 'thisisapassword')
		leave_review_KFC('so so', 3)
		leave_review_KFC('great', 5)
		expect(current_path).to eq '/restaurants'
		expect(page).to have_content 'You have already reviewed this restaurant'
	end

	scenario 'users cannot delete review unless signed in' do
		sign_up_and_in('test@test.com', 'thisisapassword')
		leave_review_KFC('so so', 3)
		sign_out
		click_link 'Delete review for KFC'
		expect(current_path).to eq '/users/sign_in'
		expect(page).to have_content 'You need to sign in or sign up before continuing'
	end

	scenario 'allows users to only delete their own reviews' do
		sign_up_and_in('test@test.com', 'thisisapassword')
		leave_review_KFC('so so', 3)
		click_link 'Delete review for KFC'
		expect(current_path).to eq '/restaurants'
		expect(page).not_to have_content 'so so'
		expect(page).to have_content 'Review deleted successfully'
	end

	scenario 'only allows users to delete their own reviews' do
		sign_up_and_in('test@test.com', 'thisisapassword')
		leave_review_KFC('so so', 3)
		sign_out
		sign_up_and_in('testagain@test.com', 'thisisanotherpassword')
		click_link 'Delete review for KFC'
		expect(page).to have_content 'You can only delete your own reviews'
		expect(current_path).to eq '/restaurants'
		expect(page).to have_content 'so so'
	end

	feature 'average ratings' do

		before do
			Restaurant.create name:'KFC'
			leave_multiple_reviews
		end

		scenario 'you can see the average rating left by reviewers' do

			# expect(page).to have_content 'You can only delete your own reviews'
			# expect(current_path).to eq '/restaurants'
			# expect(page).to have_content 'so so'
		end
	end
end
