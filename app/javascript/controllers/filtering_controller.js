import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    // lets me know controller is functioning properly
    console.log("Filtering Controller Loaded");
  }

  // filters recipes when user chooses a sort option, 
  // selects ingredients or clicks on a category
  filterRecipes(event) {
    const url = $('.sort-options').data('url');

    const sortOption = $('.sort-options').val();
    const ingredientIds = getIngredientIds();
    const recipeIds = getRecipeIds();
    const categoryId = getCategoryId(event);

    updateCurrentCategory(categoryId);

    $.ajax({
      type: 'GET',
      dataType: 'html',
      url: url,
      data: {
        'sortOption': sortOption,
        'ingredientIds': ingredientIds,
        'recipeIds': recipeIds,
        'categoryId': categoryId
      },
      success: function (response) {
        $('.recipe-cards').html(response);
        resetPageValue();
      }
    });
  }
}

// ----------- HELPERS ------------

function getCategoryId({ target }) {
  var categoryId = $('.current-category').data('value');
  if (target.classList.contains('category-option')) {
    categoryId = target.getAttribute('data-value');
  }
  return categoryId;
}

function getRecipeIds() {
  var recipeIds = [];
  $('.card').each(function () {
    recipeIds.push($(this).data('value'));
  });
  return recipeIds;
}

// gets selected ingredient ids from liquor cabinet display
// select options and returns them in an array
function getIngredientIds() {
  var ingredientIds = [...$('.cabinet-spirits').val(),
  ...$('.cabinet-modifiers').val(),
  ...$('.cabinet-sugars').val(),
  ...$('.cabinet-garnishes').val()];
  return ingredientIds;
}

function resetPageValue() {
  var recipeCards = document.querySelector('.recipe-cards');
  recipeCards.setAttribute('data-pagination-page-value', 2);
}

function updateCurrentCategory(id = null) {
  $('.current-category').data('value', id);
}