# frozen_string_literal: true

class AddIndexToRecipesRatings < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_index :recipes, :ratings, algorithm: :concurrently
  end
end
