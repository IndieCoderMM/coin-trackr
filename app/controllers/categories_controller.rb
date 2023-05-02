class CategoriesController < ApplicationController
    before_action :authenticate_user!

    def index
        @categories = current_user.categories.all 
    end

    def show
        @category = Category.find(params[:id])
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

    private

    def category_params
        params.require(:category).permit(:name, :icon)
    end

end
