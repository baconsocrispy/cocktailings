import { Controller } from "@hotwired/stimulus";
import "jquery";


export default class extends Controller {
  connect() {
    $('form').on('click', '.add_step', function(e) {
      e.preventDefault();
      $('.fields').append($('#step_form'));
    });
  }
}