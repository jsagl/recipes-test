import React from "react";

const RecipeOverview = ({recipe, setHighlightedRecipe}) => {
    return (
        <div className="flex border-2 p-1 mb-3 cursor-pointer hover:bg-gray-300" onClick={() => setHighlightedRecipe(recipe)}>
            <div className="font-bold me-3">{recipe.title}</div>
            <div className="me-3">-</div>
            <div className="me-3">{recipe.ratings} stars</div>
            {
                recipe.matched_unique_ingredients_count &&
                    <>
                        <div className="me-3">-</div>
                        <div style={{color: 'red'}}> {recipe.matched_unique_ingredients_count} matched ingredient(s)</div>
                    </>
            }
        </div>
    )
}

export default RecipeOverview;
