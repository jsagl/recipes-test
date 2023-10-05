# frozen_string_literal: true

module Api
  module V1
    class RecipesController < ApplicationController
      def index
        recipes = Services::RecipesRetriever.call(params)

        render json: formatted_recipes(recipes)
      end

      private

      # TODO create proper decorators
      def formatted_recipes(recipes)
        recipes.map do |recipe|
          recipe.instance_eval do
            {
              id: id,
              title: title,
              matched_unique_ingredients_count: try(:matched_unique_ingredients_count),
              ratings: ratings,
              ingredients: recipe_ingredients.map(&:name),
            }.compact
          end
        end
      end
    end
  end
end
