import 'jquery';
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Portions Controller Loaded");
  }

  addIngredients(e) {
    e.preventDefault();
    console.log("Prevent Default Working");
    var url = $('#add-ingredients-btn').data('url');
    var ingredientIds = getIngredientIds();
    var portionIds = getPortionIds();
    $.ajax({
      type: "GET",
      // need to add this to put the CSRF token in the HTTP header
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));},
      url: url,
      dataType: 'html',
      // need to use jQuery.param method to nest params properly
      data: jQuery.param({ portion: { ingredientIds: ingredientIds, portionIds: portionIds }}),
      success: function(response) {
        $('#test').append(response);
      }
    });
  }
}

function getIngredientIds() {
  var spirit_ids = $('.spirits-select').val();
  var mixer_ids = $('.mixers-select').val();
  var garnish_ids = $('.garnishes-select').val();

  return [...spirit_ids, ...mixer_ids, ...garnish_ids];
}

function getPortionIds() {
  const portionIds = $.map($('#test').children(), function(child) {
    return $(child).attr('id');
  });
  return portionIds;
}