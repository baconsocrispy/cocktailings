import 'jquery';
import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="test"
export default class extends Controller {
  connect() {
    console.log("Ingredients Controller Loaded");
  }
  addIngredients(e) {
    e.preventDefault();
    console.log("Prevent Default Working");
    ingredientIds = getIngredientIds();
    $.ajax({
      type: 'GET',
      url: 
    })
  }
}

function getIngredientIds() {
  var spirit_ids = $('.spirits-select').val();
  var mixer_ids = $('.mixers-select').val();
  var garnish_ids = $('.garnishes-select').val();

  return [...spirit_ids, ...mixer_ids, ...garnish_ids];
}
