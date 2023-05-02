require 'rails_helper'

RSpec.describe Expense, type: :model do
  let(:user) { User.create!(name: 'Tom', email: 'tom@gmail.com', password: 'password') }
  let(:category) { Category.create!(user:, name: 'Food', icon: '🍔') }
  let(:expense) { Expense.create!(author: user, name: 'Lunch', amount: 10, categories: [category]) }

  describe 'validations' do
    it 'should not valid if name is not present' do
      expense.name = nil
      expect(expense).to_not be_valid
    end

    it 'should not valid if amount is not present' do
      expense.amount = nil
      expect(expense).to_not be_valid
    end

    it 'should not valid if amount is negative' do
      expense.amount = -100
      expect(expense).to_not be_valid
    end
  end

  describe 'associations' do
    it 'should include at least one category' do
      expect(expense.categories).to include(category)
    end
  end
end
