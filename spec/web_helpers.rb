module SessionHelpers

  def sign_up_and_in
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end

  def sign_up_and_in_two
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: 'another@example.com')
    fill_in('Password', with: 'testagain')
    fill_in('Password confirmation', with: 'testagain')
    click_button('Sign up')
  end

  def add_restaurant_KFC
    visit '/restaurants'
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'KFC'
    click_button 'Create Restaurant'
  end

  def leave_review_KFC
    visit '/restaurants'
		click_link 'Review KFC'
		fill_in 'Thoughts', with: 'so so'
		select '3', from: 'Rating'
		click_button 'Leave Review'
  end

  def sign_out
    click_link 'Sign out'
  end
end
