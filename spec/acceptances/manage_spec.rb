require 'rails_helper'

feature 'Manage users', type: :feature do
  scenario 'Show the list of users', js: true do
    User.create!(name: 'Guirec Corbel', age: 29)
    visit users_path
    expect(page).to have_content('Guirec Corbel')
  end

  scenario 'Create a new user', js: true do
    visit users_path
    click_on 'Add a new'
    fill_in 'Name', with: 'Guirec Corbel'
    fill_in 'Age', with: 29
    click_on 'Save changes'

    expect(page).to have_content('Guirec Corbel')
  end
end
