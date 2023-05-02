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
            flash[:success] = 'Expense added successfully!'
            redirect_to category_path(@category)
        else 
            flash[:alert] = 'Please try again!'
            render :new 
        end
    end

    def destroy
        @category = Category.find(params[:category_id])
        @expense = Expense.find(params[:id])
        @expense.destroy
        
        flash[:success] = 'Removed an expense item!'
        redirect_to category_path(@category)
    end

    private 

    def expense_params
        params.require(:expense).permit(:name, :amount, category_ids: [])
    end
end
