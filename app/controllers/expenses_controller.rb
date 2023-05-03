class ExpensesController < ApplicationController
    before_action :authenticate_user!
    
    def new 
        @categories = current_user.categories
        @category = Category.find(params[:category_id])
        @expense = Expense.new 
    end

    def create 
        @category = Category.find(params[:category_id])
        @expense = Expense.new(expense_params)
        @expense.author = current_user

        if @expense.save
            flash[:success] = "You've just added a new expense."
            redirect_to category_path(@category)
        else 
            error = @expense.errors.full_messages[0]
            flash[:error] = "#{error}. Please try again."
            redirect_to new_category_expense_path(@category)
        end
    end

    def destroy
        @category = Category.find(params[:category_id])
        @expense = Expense.find(params[:id])
        @expense.destroy
        
        flash[:success] = "Expense item has been removed."
        redirect_to category_path(@category)
    end

    private 

    def expense_params
        params.require(:expense).permit(:name, :amount, category_ids: [])
    end
end
