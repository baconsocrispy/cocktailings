import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    // lets me know controller is function properly
    console.log("Cabinets Controller Loaded");

    // calls changeLiquorCabinet function below when a new 
    // liquor cabinet is selected
    $(document).on('change', '.cabinet-select', changeLiquorCabinet);

    // calls filterCabinetIngredients when ingredients are selected/deselected
    // in the liquor cabinet display
    $(document).on('change', '.cabinet-ingredients', filterCabinetIngredients);

    $('.category-option').on('click', filterByCategory);

    // resets select box value to [] when user clicks on '- None -' option
    $('.cabinet-ingredients option').on('click', function(e) {
      if ($(this).html() == '- None -') {
        $(this).closest('.cabinet-ingredients').val([]);
        filterCabinetIngredients();
      }
    });

    // $(document).click(function(e) {
    //   console.log(!$(e.target).closest('.change-cabinet').length);
    //   console.log($('.cabinet-select').is(':visible'));
    //   if (!$(e.target).closest('.change-cabinet').length && $('.cabinet-select').is(':visible')) {
    //     $('.cabinet-select').hide();
    //   }
    // });
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
    }
  });
}

function filterByCategory() {
  var categoryId = $(this).data('value');
  var ingredientIds = getIngredientIds();
  var sort_option = $('.sort-options').val();
  var recipeIds = getRecipeIds();

  $.ajax({
    type: 'GET',
    dataType: 'html',
    url: $('.sort-options').data('url'),
    data: { 'sort_option': sort_option, 'ingredientIds': ingredientIds, 'categoryId': categoryId, 'recipeIds': recipeIds },
    success: function (response) {
      $('.recipe-cards').html(response);
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
