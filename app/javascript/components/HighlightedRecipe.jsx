import React from "react";

const HighlightedRecipe = ({recipe}) => {
    return (
        <div className="w-1/2">
            <div className="text-4xl font-bold me-3">{recipe.title}</div>
            <ul>
                {recipe.ingredients.map((ingredient) => <li>{ingredient}</li>)}
            </ul>
        </div>
    )
}

export default HighlightedRecipe;
