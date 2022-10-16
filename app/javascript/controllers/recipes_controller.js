import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="test"
export default class extends Controller {
  connect() {
    console.log("Recipes Controller Loaded");

    // display file-name when img uploaded to recipe form
    $('#add-image-btn').on('change', function() {
      var file_name = $('#add-image-btn')[0].files[0].name;
      $('#img-file-name').html('File added: ' + file_name);
    });
  }

  // handles recipe favoriting/unfavoriting logic
  favorite(e) {
    $.ajax({
      beforeSend: function (xhr) { xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')); },
      type: 'POST',
      dataType: 'json',
      url:  $(e.target).data('url'),
      data: {id: $(e.target).val()},
      success: function(response) {
        if (response['favorite']) {
          $(e.target).removeClass('fa-regular').addClass('fa-solid');
        } else {
          $(e.target).removeClass('fa-solid').addClass('fa-regular');
        }
      }
    }); 
  }
}