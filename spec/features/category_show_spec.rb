require 'rails_helper'

RSpec.feature 'Transactions Page', type: :feature do
  include Devise::Test::IntegrationHelpers

  let!(:user) { User.create!(name: 'John', email: 'john@gmail.com', password: 'password') }
  let!(:category) { Category.create!(user:, name: 'Food', icon: '🍔') }
  let!(:expense1) { Expense.create!(author: user, name: 'Lunch', amount: 10, categories: [category]) }
  let!(:expense2) { Expense.create!(author: user, name: 'Dinner', amount: 20, categories: [category]) }

  before do
    sign_in user
    visit category_path(category)
  end

  scenario 'User can see the list of expenses' do
    expect(page).to have_content(expense1.name)
    expect(page).to have_content(expense2.name)
  end

  scenario 'User can see expenses ordered by most recent' do
    expect(page.all('.item-card').first).to have_content(expense2.name)
    expect(page.all('.item-card').last).to have_content(expense1.name)
  end

  scenario 'User can see total amount for the category' do
    expect(page).to have_content("$#{category.total_expense}.00")
  end

  scenario 'User can navigate to new transaction page' do
    click_link 'Add Expense'
    expect(current_path).to eq new_category_expense_path(category)
  end
end
