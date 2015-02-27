require 'rails_helper'

feature "Manage users", type: :feature do
  scenario "Show the list of users", js: true do
    User.create!(name: "Guirec Corbel", age: 29)
    visit users_path
    expect(page).to have_content("Guirec Corbel")
  end
end
