import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    // lets me know controller is functioning properly
    console.log("Filtering Controller Loaded");
  }

  // filters/searches recipes when user chooses a sort option, 
  // selects ingredients, clicks on a category or enters a search term
  filterRecipes(event) {
    event.preventDefault();

    const url = getUrl(event);
    const params = getParams(event);

    $.ajax({
      type: 'GET',
      dataType: 'html',
      url: url,
      data: params,
      success: function (response) {
        $('.recipe-cards').html(response);
        resetPageValue();
      }
    });
  }
}

// ----------- HELPERS ------------
function getUrl({ target }) {
  var url = $('.sort-options').data('url');
  if (target.id === 'search-btn') {
    url = target.getAttribute('data-url');
  }
  return url;
}

function getCategoryId({ target }) {
  var categoryId = $('.current-category').data('value');
  if (target.classList.contains('category-option')) {
    categoryId = target.getAttribute('data-value');
  }
  return categoryId;
}

function getIngredientIds() {
  var ingredientIds = [...$('.cabinet-spirits').val(),
  ...$('.cabinet-modifiers').val(),
  ...$('.cabinet-sugars').val(),
  ...$('.cabinet-garnishes').val()];
  // if (ingredientIds.length === 0) return null;
  return ingredientIds.filter(n => n);
}

function resetPageValue() {
  var recipeCards = document.querySelector('.recipe-cards');
  recipeCards.setAttribute('data-pagination-page-value', 2);
}

function updateCurrentCategory(id = null) {
  $('.current-category').data('value', id);
}

function getParams(event) {
  const searchTerm = $('#search-field').val();
  const sortOption = $('.sort-options').val();
  const ingredientIds = getIngredientIds();
  const categoryId = getCategoryId(event);

  updateCurrentCategory(categoryId);

  return {
    'sortOption': sortOption,
    'ingredientIds': ingredientIds,
    'categoryId': categoryId,
    'searchTerm': searchTerm
  };
}