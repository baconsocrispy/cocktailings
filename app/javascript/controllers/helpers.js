// configures url params for pagination feature and returns
// url as a string
export function configureUrl(urlValue, pageValue) {
  const params = getParams(pageValue);
  var url = new URL(urlValue);
  url.search = new URLSearchParams($.param(params));
  return url;
}

// gathers all currently selected search options
// and returns tham as an object 
export function getParams(pageValue = null) {
  return {
    'page': pageValue,
    'search': {
      'sortOption': getSortOption(),
      'ingredientIds': getIngredientIds(),
      'categoryIds': getCategoryId(),
      'searchTerm': $('#current-search').val()
    }
  };
}

// gets the currently selected tab value
function getSortOption() {
  const selectedOption = document.querySelector(".sorting-option[data-isSelected='true']");
  return selectedOption.innerHTML;
}

// gets category from hidden current-category div
// or directly from a clicked category
function getCategoryId() {
  const selectedCategory = 
    document
      .querySelector(".category-item[data-isSelected='true']")
      .getAttribute('data-value');

  return [selectedCategory].filter(n => n); 
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


// ----------  RESET HELPERS ------------------
export function reset() {
  resetCategory();
  resetIngredients();
  resetSortOption();
}

export function resetPage() {
  resetPageValue();
  $('#search-field').val('');
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


// ----------  FORM HELPERS ------------------

export function formatIngredientDisplay(ingredient_form) {
  $(ingredient_form).find('.ingredient-input').hide();

  const ingredient = $(ingredient_form)
    .find('.ingredient-name')
    .children(':selected')
    .html();

  const amount = $(ingredient_form)
    .find('.ingredient-amount')
    .val();

  const unit = $(ingredient_form)
    .find('.ingredient-unit')
    .children(':selected')
    .val();
  
    const remove = $(ingredient_form)
      .find('.remove-btn')
      .show();

  $(ingredient_form)
    .find('.ingredient-display')
    .html([ingredient, amount, unit].join(' '))
    .show();
}


