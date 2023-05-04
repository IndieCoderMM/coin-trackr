class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.includes(:expenses).where(user: current_user)
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
    @category.user = current_user

    if @category.save
      flash[:success] = 'New category has been created.'
      redirect_to categories_path
    else
      error = @category.errors.full_messages[0]
      flash[:error] = "#{error}. Please try again."
      redirect_to new_category_path
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    flash[:success] = "#{@category.name} category has been deleted."
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
