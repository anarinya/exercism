/// <reference path="./global.d.ts" />
// @ts-check

const cookingStatus = (remainingMinutes) => {
  if (remainingMinutes === undefined) return "You forgot to set the timer.";
  return remainingMinutes === 0 ? "Lasagna is done." : "Not done, please wait.";
}

const preparationTime = (layers, timePerLayer = 2) => layers.length * timePerLayer;

const quantities = (layers) => {
  const ingredients = { noodles: 50, sauce: 0.2 };
  return layers.reduce((sum, item) => {
    if (["sauce", "noodles"].includes(item)) sum[item] += ingredients[item];
    return sum;
  }, { noodles: 0, sauce: 0 });
}

const addSecretIngredient = (friendsList, myList) => {
  myList.push(friendsList[friendsList.length - 1]);
  return;
}

const scaleRecipe = (recipe, portions) => Object.keys(recipe).reduce((newRecipe, key) => {
  const singlePortion = newRecipe[key] / 2;
  return newRecipe[key] = singlePortion * portions, newRecipe;
}, { ...recipe });

export {
  cookingStatus,
  preparationTime,
  quantities,
  addSecretIngredient,
  scaleRecipe
}