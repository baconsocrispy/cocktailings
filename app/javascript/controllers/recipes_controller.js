import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    // updates recipe count based on results
    $('#recipe-count').html('Total Recipes: ' + $('#recipes').data('value'));
  }

  showRecipe() {
    const url = $(this.element).data('url');
    $.ajax({
      type: 'GET',
      url: url,
    });
  }

  favorite(e) {
    const url = $(this.element).data('url');
    $.ajax({
      beforeSend: function (xhr) { xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')); },
      type: 'POST',
      dataType: 'html',
      url: url,
      success: function (response) {
        $(e.target).closest('.favoriting-widget').html(response);
      }
    });
  }
}

