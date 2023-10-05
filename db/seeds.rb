# frozen_string_literal: true

path = File.join(File.dirname(__FILE__), "./recipes-en.json")
file = File.read(path)
data = JSON.parse(file)

data.each do |recipe_data|
  recipe = Recipe.create!(
    title: recipe_data['title'],
    cook_time: recipe_data['cook_time'],
    prep_time: recipe_data['prep_time'],
    ratings: recipe_data['ratings'],
    cuisine: recipe_data['cuisine'],
    category: recipe_data['category'],
    image: recipe_data['image']
  )

  recipe_data['ingredients'].each { |name| RecipeIngredient.create!(recipe:, name:) }
end


