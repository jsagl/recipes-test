import React, {useCallback, useEffect, useState} from "react";
import RecipeOverview from "./RecipeOverview";
import { debounce } from 'lodash';

const fetchRecipes = (ingredients, setRecipes) => {
    const url = `/api/v1/recipes?ingredients=${ingredients}`;
    fetch(url)
        .then((res) => {
            if (res.ok) {
                return res.json();
            }
            throw new Error("Network response was not ok.");
        })
        .then((res) => setRecipes(res))
        .catch((e) => console.log(e));
}

const RecipesList = ({ingredients, setHighlightedRecipe}) => {
    const [recipes, setRecipes] = useState([]);

    const debouncedLoadRecipes = useCallback(debounce(fetchRecipes, 300), [])

    useEffect(() => {
        debouncedLoadRecipes(ingredients, setRecipes)
    }, [ingredients]);

    return recipes.map((recipe) => {
        return <RecipeOverview key={recipe.id} recipe={recipe} setHighlightedRecipe={setHighlightedRecipe} />
    })
};

export default RecipesList;
