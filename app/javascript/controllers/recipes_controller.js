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
}