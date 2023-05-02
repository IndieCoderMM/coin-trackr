class CategoriesController < ApplicationController
    before_action :authenticate_user!

    def index
        @categories = current_user.categories.includes(:expenses).all
        @unique_expenses = Expense.joins(:categories).where(categories: @categories).distinct
        @total_expense = @unique_expenses.sum(:amount)
    end

    def show
        @category = Category.includes(:expenses).find(params[:id])
        @expenses = @category.expenses.order(updated_at: :desc)
    end

    def new 
        @category = Category.new
    end

    def create
        @category = Category.new(category_params)
        @category.user= current_user

        if @category.save
            flash[:success] = 'Category created successfully!'
            redirect_to categories_path
        else 
            flash[:alert] = 'Please try again!'
            render :new 
        end
    end

    def destroy
        @category = Category.find(params[:id])
        @category.destroy
        
        flash[:success] = 'Deleted a category item!'
        redirect_to categories_path
    end

    private

    def category_params
        params.require(:category).permit(:name, :icon)
    end

end
