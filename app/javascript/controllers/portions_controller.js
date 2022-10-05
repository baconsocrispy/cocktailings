import 'jquery';
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Portions Controller Loaded");
  }

  // collects the ingredient ids from select boxes, collects the ids from
  // the portion table rows, makes an ajax call to the new portion controller
  // after nesting all the ids properly with the $.params method. Appends any
  // unlisted selected ingredients to the portion table. 
  addPortions(e) {
    e.preventDefault();
    var url = $('#add-portions-btn').data('url');
    var ingredientIds = getIngredientIds();
    var portionIds = getPortionIds();
    $.ajax({
      type: "GET",
      // need to add this to put the CSRF token in the HTTP header
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));},
      url: url,
      dataType: 'html',
      data: $.param({ portion: { ingredientIds: ingredientIds, portionIds: portionIds }}),
      success: function(response) {
        $('#recipe-portions-tbl').append(response);
      }
    });
  };

  deletePortion(e) {
    e.preventDefault();
    $(e.target).closest('tr').remove()
  };

  deletePortionObject(e) {
    e.preventDefault();
    const url = $(e.target).data('url')
    $(e.target).closest('tr').remove()
    $.ajax({
      type: "DELETE",
      beforeSend: function (xhr) { xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')); },
      url: url,
      success: function (response) {
        console.log('Successfully deleted portion');
      }
    })
  }
};

// HELPER FUNCTIONS
function getIngredientIds() {
  var spirit_ids = $('.spirits-select').val();
  var mixer_ids = $('.mixers-select').val();
  var garnish_ids = $('.garnishes-select').val();

  return [...spirit_ids, ...mixer_ids, ...garnish_ids];
};

function getPortionIds() {
  const portionIds = $.map($('#recipe-portions-tbl').children(), function(child) {
    return $(child).attr('id');
  });
  return portionIds;
};