import * as React from "react";
import RecipesList from "./RecipesList";
import IngredientsInput from "./IngredientsInput";
import {useState} from "react";
import HighlightedRecipe from "./HighlightedRecipe";

const Home = ({}) => {
    const [ingredients, setIngredients] = useState('');
    const [highlightedRecipe, setHighlightedRecipe] = useState(null);

    return (
        <div className="m-10">
            <div className="flex">
                <div className="w-1/2 me-5">
                    <IngredientsInput ingredients={ingredients} setIngredients={setIngredients} />
                    <RecipesList ingredients={ingredients} setHighlightedRecipe={setHighlightedRecipe} />
                </div>
                {highlightedRecipe && <HighlightedRecipe recipe={highlightedRecipe}/>}
            </div>
        </div>
    )
};

export default Home;
