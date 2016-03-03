module SessionHelpers

  def sign_up_and_in(email, password)
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: email)
    fill_in('Password', with: password)
    fill_in('Password confirmation', with: password)
    click_button('Sign up')
  end


  def add_restaurant_KFC
    visit '/restaurants'
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'KFC'
    click_button 'Create Restaurant'
  end

  def leave_review_KFC(thoughts, rating)
    click_link 'Review KFC'
    fill_in 'Thoughts', with: thoughts
    select rating, from: 'Rating'
    click_button 'Leave Review'
  end

  def sign_out
    click_link 'Sign out'
  end

  def leave_multiple_reviews
    sign_up_and_in('test@test.com', 'thisisapassword')
    leave_review_KFC('so so', 3)
    sign_out
    sign_up_and_in('anothertest@test.com', 'thisisyetanotherpassword')
    leave_review_KFC('great', 5)
    sign_out
  end


end
