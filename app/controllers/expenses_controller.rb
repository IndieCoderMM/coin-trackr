class ExpensesController < ApplicationController
    def new 
        @category = Category.find(params[:category_id])
        @expense = Expense.new 
    end

    def create 
        @expense = Expense.new(expense_params)
        @expense.author = current_user

        if @expense.save
            flash[:success] = 'Expense added successfully!'
            redirect_to categories_path
        else 
            flash[:alert] = 'Please try again!'
            render :new 
        end
    end

    private 

    def expense_params
        params.require(:expense).permit(:name, :amount, category_ids: [])
    end
end
