import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="test"
export default class extends Controller {
  connect() {
    console.log("Ingredients Controller Loaded");
  }
  
  searchIngredients() {
    var url = $('.ui-autocomplete-input').data('autocomplete-source');
    console.log(url);
    $.ajax({
      type: 'GET',
      DataType: 'json',
      url: url,
      success: function(response) {
        console.log(response);
        $('.ui-autocomplete-input').autocomplete({
          source: response
        }).data('autocomplete')._renderItem = function()
      }
      $('')
    });
  }
}