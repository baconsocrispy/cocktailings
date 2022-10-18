import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Recipes Controller Loaded");

    // display file-name when img uploaded to recipe form
    $('#add-image-btn').on('change', function() {
      var file_name = $('#add-image-btn')[0].files[0].name;
      $('#img-file-name').html('File added: ' + file_name);
    });
  }

  favorite(e) {
    var url = $(this.element).data('url');
    $.ajax({
      beforeSend: function (xhr) { xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')); },
      type: 'POST',
      dataType: 'html',
      url: url,
      success: function (response) {
        $('.favoriting-widget').html(response);
      }
    });
  }
}

