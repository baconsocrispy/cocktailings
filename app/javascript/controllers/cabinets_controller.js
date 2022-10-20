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


    // $(document).on('click', '.cabinet-ingredients option', deselectOption);
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

// gets selected ingredient ids from liquor cabinet display
// select options and returns them in an array
function getIngredientIds() {
  var ingredientIds = [...$('.cabinet-spirits').val(),
                       ...$('.cabinet-modifiers').val(),
                       ...$('.cabinet-sugars').val(),
                       ...$('.cabinet-garnishes').val()];
  return ingredientIds;
}

// filters recipes by criteria selected in the liquor cabinet display
// and which sort option is selected
function filterCabinetIngredients() {
  var ingredientIds = getIngredientIds();
  var url = $('.sort-options').data('url');
  var sort_option = $('.sort-options').val();
  $.ajax({
    type: 'GET',
    dataType: 'html',
    url: url,
    data: { 'sort_option': sort_option, 'ingredientIds': ingredientIds },
    success: function (response) {
      $('.recipe-cards').html(response);
    }
  });
}

function deselectOption(e) {
  console.log($('.cabinet-ingredients').val());
  if ($('.cabinet-ingredients').val().includes($(this).val())) {
    $(this).prop('selected', false);
  }
}