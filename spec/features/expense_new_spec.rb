require 'rails_helper'

RSpec.feature 'New Expense Page', type: :feature do
  include Devise::Test::IntegrationHelpers

  let!(:user) { User.create!(name: 'John', email: 'john@gmail.com', password: 'password') }
  let!(:category) { Category.create!(user:, name: 'Food', icon: '🍔') }
  let!(:expense) { Expense.create!(author: user, name: 'Lunch', amount: 10, categories: [category]) }

  before do
    sign_in user
    visit new_category_expense_path(category)
  end

  scenario 'User can create a new expense' do
    fill_in 'Name', with: 'Lunch'
    fill_in 'Amount', with: 50
    check 'Food'
    click_button 'Add Expense'

    expect(current_path).to eq category_path(category)
    expect(page).to have_content("Success! You've just added a new expense.")
  end

  scenario 'User can see an error message if something wrong' do
    fill_in 'Name', with: nil
    check 'Food'
    click_button 'Add Expense'

    expect(current_path).to eq new_category_expense_path(category)
    expect(page).to have_content "Name can't be blank"
  end
end
