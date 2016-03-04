require 'rails_helper'

feature 'endorsing reviews' do
  before do
    kfc = Restaurant.create(name: 'KFC')
    kfc.reviews.create(rating: 3, thoughts: 'Not bad chicken')
  end

  scenario 'shows you how many endorsements a review has' do
    visit '/restaurants'
    # click_link 'Endorse this review of KFC'
    expect(page).to have_content('0 endorsements')
  end

  scenario 'user can endorse review, which updates the review endorsement count', js: true do
    visit '/restaurants'
    click_link 'Endorse this review of KFC'
    expect(page).to have_content('1 endorsement')
  end
end
