# frozen_string_literal: true

class CreateRecipeIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :recipe_ingredients, id: :uuid do |t|
      t.references :recipe, type: :uuid, index: true, foreign_key: { to_table: :recipes }
      t.string :name, index: true

      t.timestamps
    end
  end
end
