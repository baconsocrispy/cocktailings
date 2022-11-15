// gets the currently selected tab value
export function getSortOption() {
  const selectedOption = document.querySelector(".sorting-option[data-isSelected='true']");
  return selectedOption.innerHTML;
}

// gets category from hidden current-category div
// or directly from a clicked category
export function getCategoryId(e) {
  var categoryId = $('.current-category').data('value');

  // handler for pagination
  if (!e) return categoryId;

  // handler for when category directly clicked on
  if (e.target.classList.contains('category-item')) {
    categoryId = e.target.getAttribute('data-value');
  }
  return categoryId;
}

// gets all the currently selected ingredient ids
// from the cabinet sidebar and cleans any empty 
// strings from the result
function getIngredientIds() {
  const ingredientIds = [...$('.cabinet-spirits').val(),
  ...$('.cabinet-modifiers').val(),
  ...$('.cabinet-sugars').val(),
  ...$('.cabinet-garnishes').val()];
  return ingredientIds.filter(n => n);
}

// if there are ingredientIds, appends them as an array to searchParams
function appendIngredientIds(url) {
  var ingredientIds = getIngredientIds();
  if (ingredientIds.length) {
    ingredientIds.map(i => url.searchParams.append('ingredientIds', i));
  }
  return url;
}

// configures url params for pagination feature and returns
// url as a string
export function configureUrl(urlValue, pageValue) {
  const sortingOption = getSortOption();
  var url = new URL(urlValue);

  url.searchParams.set('page', pageValue);
  url.searchParams.append('sortOption', sortingOption);
  url.searchParams.append('categoryId', getCategoryId());
  url.searchParams.append('searchTerm', $('#search-field').val());
  url = appendIngredientIds(url);
  return url.toString();
}

// gathers all currently selected search options
// and returns tham as an object 
export function getParams(event) {
  const searchTerm = $('#search-field').val();
  const sortOption = getSortOption;
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

// resets page value to 2 when results are refreshed
// so that pagination will continue to flow properly
export function resetPageValue() {
  var recipeCards = document.querySelector('.recipe-cards');
  recipeCards.setAttribute('data-pagination-page-value', 2);
}

// updates the value of the hidden current-category element
function updateCurrentCategory(id = null) {
  $('.current-category').data('value', id);
};
