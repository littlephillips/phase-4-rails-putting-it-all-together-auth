class RecipesController < ApplicationController

    before_action :authorize    


    def index
        recipe = Recipe.all 
        render json: recipe
    end

    def create
        recipe = Recipe.create(recipe_params)
        if recipe.valid?
            render json: recipe, include: :user
            render json: { error: [recipe.errors.full_messages] }, status: :unprocessable_entity
        end
    end

    private 
    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end

    def authorize
        return render json: {errors: ["Not authorized"]}, status: :unauthorized unless session.include? :user_id
    end
end
