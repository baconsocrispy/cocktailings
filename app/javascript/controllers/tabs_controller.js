import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  updateSortOption({ target }) {
    $('.sorting-option').each((_, option) => option.setAttribute('data-isSelected', false));
    target.setAttribute('data-isSelected', true);
  }

  toggleMobileSortMenu() {
    var isOpen = $('#mobile-sort-menu-container').data('isOpen');
    $('#mobile-sort-menu-container').data('isOpen', !isOpen);
  }

  closeSortMenu() {
    $('body').css('position', 'absolute');
    $('#mobile-sort-menu-container').hide();
  }

  openSortMenu() {
    $('body').css('position', 'fixed');
    $('#mobile-sort-menu-container').show();
  }
}