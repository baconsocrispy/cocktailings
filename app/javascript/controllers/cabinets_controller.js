import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    // lets me know controller is function properly
    console.log("Cabinets Controller Loaded");

    // adds onChange listener for when user changes the current cabinet
    $(document).on('change', '.cabinet-select', changeLiquorCabinet);

    // adds onChange listener to the liquor cabinet display ingredient select options
    $(document).on('change', '.cabinet-ingredients', filterCabinetIngredients);

    // adds click listener to category options 
    $('.category-option').on('click', filterByCategory);

    // resets select box value to [] when user clicks on '- None -' option
    $('.cabinet-ingredients option').on('click', function(e) {
      if ($(this).html() == '- None -') {
        $(this).closest('.cabinet-ingredients').val([]);
        filterCabinetIngredients();
      }
    });
  }

  // opens liquor cabinet select popup when 'change' button clicked
  toggleCabinetSelect(e) {
    e.preventDefault();
    $('.cabinet-select-wrapper').addClass('d-block').removeClass('d-none');
  }
}

// filters recipes by criteria selected in the liquor cabinet display
// and which sort option is selected
function filterCabinetIngredients() {
  var ingredientIds = getIngredientIds();
  var url = $('.sort-options').data('url');
  var sort_option = $('.sort-options').val();
  var recipeIds = getRecipeIds();

  $.ajax({
    type: 'GET',
    dataType: 'html',
    url: url,
    data: { 'sort_option': sort_option, 'ingredientIds': ingredientIds, 'recipeIds': recipeIds },
    success: function (response) {
      $('.recipe-cards').html(response);
      resetPageValue();
    }
  });
}

function filterByCategory() {
  var categoryId = $(this).data('value');
  var ingredientIds = getIngredientIds();
  var sort_option = $('.sort-options').val();
  var recipeIds = getRecipeIds();

  updateCurrentCategory(categoryId);

  $.ajax({
    type: 'GET',
    dataType: 'html',
    url: $('.sort-options').data('url'),
    data: { 'sort_option': sort_option, 'ingredientIds': ingredientIds, 'categoryId': categoryId, 'recipeIds': recipeIds },
    success: function (response) {
      $('.recipe-cards').html(response);
      resetPageValue();
    }
  });
}

function getRecipeIds() {
  var recipeIds = [];
  $('.card').each( function() {
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

// reloads liquor cabinet display with selected liquor cabinet
function changeLiquorCabinet(e) {
  var cabinet_id = $(e.target).val();
  $.ajax({
    type: 'GET',
    dataType: 'html',
    data: { update_id: cabinet_id },
    url: $(e.target).data('url'),
    success: function (response) {
      $('.liquor-cabinet-display').html(response);
    }
  });
}

function resetPageValue() {
  console.log('TEST');
  var recipeCards = document.querySelector('.recipe-cards');
  recipeCards.setAttribute('data-pagination-page-value', 2);
  console.log($('.recipe-cards').data('pagination-page-value'));
}

function updateCurrentCategory(id=null) {
  $('.current-category').data('value', id);
}