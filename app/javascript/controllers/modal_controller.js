import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  closeModal() {
    $('#recipe-modal').hide();
    $('body').removeClass('modal-open');
    $('.modal-backdrop').remove();
  }
}