import React, {useEffect, useState} from "react";

const IngredientsInput = ({ingredients, setIngredients}) => {
    const handleChange = (e) => {
        setIngredients(e.target.value);
        console.log(ingredients);
    }

    return (
        <div>
            <div className="mb-2">Enter a pipe (|) separated list of ingredients</div>
            <input
                className="border-2 mb-5 w-full"
                type="text"
                onChange={handleChange}
                placeholder="Pipe (|) separated list of ingredients"
            />
        </div>
    )
}

export default IngredientsInput;
