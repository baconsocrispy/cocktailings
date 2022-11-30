import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  updateSortOption({ target }) {
    $('.sorting-option').each((_, option) => option.setAttribute('data-isSelected', false));
    target.setAttribute('data-isSelected', true);
  }

  updateMobileMenu({ target }) {
    const targetMenu = target.getAttribute('data-target-menu');
    var menu = $(".mobile-menu[data-target-menu='" + targetMenu + "']");

    if (targetMenu != 'change-cabinet-menu') $('.mobile-menu').hide();
    
    menu.show();
  }

  closeSortMenu() {
    $('body').css('position', 'absolute');
    $('#mobile-sort-menu-container').hide();
    $('.mobile-change-cabinet-btn').hide();
  }

  openSortMenu({ target }) {
    const targetMenu = target.getAttribute('data-target-menu');
    if (targetMenu == 'mobile-cabinet-menu') $('.mobile-change-cabinet-btn').show();

    $('body').css('position', 'fixed');
    $('#mobile-sort-menu-container').show();
  }
}