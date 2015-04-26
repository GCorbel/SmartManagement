require 'rails_helper'

feature 'Manage users', type: :feature do
  scenario 'Show the list of users', js: true do
    User.create!(name: 'Guirec Corbel', age: 29)
    visit users_path

    within('#users_table') do
      expect(page).to have_content('Guirec Corbel')
    end
  end

  scenario 'Search a user', js: true do
    User.create!(name: 'Guirec Corbel', age: 29)
    User.create!(name: 'John Test', age: 30)
    visit users_path

    within('#users_table') do
      find_search_field('name').set 'Guirec'
      expect(page).to have_content('Guirec Corbel')
      expect(page).to_not have_content('John Test')
    end
  end

  scenario 'Create a new user', js: true do
    visit users_path
    click_on 'Add a new'
    fill_in 'Name', with: 'Guirec Corbel'
    fill_in 'Age', with: 29
    click_on 'Create User'

    within('#users_table') do
      expect(page).to have_content('Guirec Corbel')
    end
  end

  scenario 'Update a user', js: true do
    User.create!(name: 'Guirec Corbel', age: 29)

    visit users_path
    click_on 'Edit'
    fill_in 'Name', with: 'Guirec Corbel2'
    click_on 'Update User'

    within('#users_table') do
      expect(page).to have_content('Guirec Corbel2')
    end
  end

  scenario 'Delete a user', js: true do
    User.create!(name: 'Guirec Corbel', age: 29)

    visit users_path
    click_on 'Delete'

    within('#users_table') do
      expect(page).to_not have_content('Guirec Corbel')
    end
  end

  def find_search_field(name)
    all('.ng-isolate-scope').each do |f|
      return f if f["st-search"].present? && f["st-search"].include?(name)
    end
  end

end
