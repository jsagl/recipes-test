# frozen_string_literal: true

module Services
  class RecipesRetriever
    DEFAULT_PAGE = 1
    DEFAULT_PER = 10

    class << self
      def call(params)
        new(params).retrieve
      end
    end

    def retrieve
      query = Recipe.all.preload(:recipe_ingredients).page(params[:page] || DEFAULT_PAGE).per(params[:per] || DEFAULT_PER)

      return query if ingredients_for_query.blank?

      query.select('recipes.*', "COUNT(DISTINCT CONCAT(recipes.id,#{sql_safe_case_statement})) AS matched_unique_ingredients_count")
            .joins(:recipe_ingredients)
            .merge(RecipeIngredient.where('name ILIKE ANY(ARRAY[?])', ingredients_for_query))
            .order('matched_unique_ingredients_count DESC', 'recipes.ratings DESC')
            .group('recipes.id')

    end

    private

    attr_accessor :params

    def initialize(params)
      self.params = params
    end

    def ingredients_for_query
      @ingredients_for_query ||= begin
        return [] if params[:ingredients].blank?
        return [] unless params[:ingredients].is_a?(String)

        params[:ingredients].split('|').first(10).filter_map do |ingredient|
          next if ingredient.length < 3

          sanitized_ingredient = ActiveRecord::Base.sanitize_sql_like(ingredient)

          "%#{sanitized_ingredient}%"
        end.uniq
      end
    end

    # Beware of SQL injections when modifying this query
    def sql_safe_case_statement
      return '' if ingredients_for_query.blank?

      case_statement = 'CASE'
      ingredients_for_query.each_with_index do |ingredient, i|
        case_statement += " WHEN recipe_ingredients.name ILIKE '#{ingredient}' THEN #{i + 1}"
      end

      case_statement += ' ELSE 0 END'

      case_statement
    end
  end
end
