# Create some users
user1 = User.create!(name: "Alice", email: "alice@example.com", password: "password")
user2 = User.create!(name: "Bob", email: "bob@example.com", password: "password")

# Create some categories for user1
category1 = Category.create!(user: user1, name: "Food", icon: "🍔")
category2 = Category.create!(user: user1, name: "Transportation", icon: "🚕")

# Create some categories for user2
category3 = Category.create!(user: user2, name: "Entertainment", icon: "🎉")

# Create some expenses for user1
expense1 = Expense.create!(author: user1, name: "Lunch", amount: 10, categories: [category1])
expense2 = Expense.create!(author: user1, name: "Taxi ride", amount: 5, categories: [category2])
expense3 = Expense.create!(author: user1, name: "Dinner", amount: 20, categories: [category1, category2])

# Create some expenses for user2
expense4 = Expense.create!(author: user2, name: "Movie ticket", amount: 15, categories: [category3])
expense5 = Expense.create!(author: user2, name: "Concert ticket", amount: 30, categories: [category3])
