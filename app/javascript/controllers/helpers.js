// gets the currently selected tab value
function getSortOption() {
  const selectedOption = document.querySelector(".sorting-option[data-isSelected='true']");
  return selectedOption.innerHTML;
}

// gets category from hidden current-category div
// or directly from a clicked category
function getCategoryId() {
  const selectedCategory = document.querySelector(".category-item[data-isSelected='true']");
  return selectedCategory.getAttribute('data-value');
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
  url.searchParams.append('searchTerm', $('#current-search').val());
  url = appendIngredientIds(url);
  return url.toString();
}

// gathers all currently selected search options
// and returns tham as an object 
export function getParams(event) {
  const searchTerm = $('#current-search').val();
  const sortOption = getSortOption;
  const ingredientIds = getIngredientIds();
  const categoryId = getCategoryId(event);

  return {
    'sortOption': sortOption,
    'ingredientIds': ingredientIds,
    'categoryId': categoryId,
    'searchTerm': searchTerm
  };
}

// resets page value to 2 when results are refreshed
// so that pagination will continue to flow properly
function resetPageValue() {
  var recipeCards = document.querySelector('.recipe-cards');
  recipeCards.setAttribute('data-pagination-page-value', 2);
}

function resetCategory() {
  $('.category-item').each((_, category) => category.setAttribute('data-isSelected', false));
  $('#all-categories').attr('data-isSelected', true);
}

function resetIngredients() {
  $('.cabinet-ingredients option').prop('selected', false);
}

function resetSortOption() {
  $('.sorting-option').attr('data-isSelected', false);
  $('.sorting-option')[0].setAttribute('data-isSelected', true);
}


export function reset() {
  resetCategory();
  resetIngredients();
  resetSortOption();
}

export function resetPage() {
  resetPageValue();
  $('#search-field').val('');
}
