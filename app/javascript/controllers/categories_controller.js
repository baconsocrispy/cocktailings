import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Categories Controller Loaded");

    // toggles the selected category check-mark
    $('.category-option').on('click', ({ target }) => {
      if ($('#category-check')) {
        $('#category-check').closest('.category-option').data('isSelected', false);
        $('#category-check').remove();
      }  
      const html = "<span id='category-check'>&check;</span>";
      $(this).data('isSelected', true);
      target.insertAdjacentHTML('afterbegin', html);
    });
  }


  toggleCategoryMenu() {
    const menu = $('.category-toggle');
    let isMenuExpanded = menu.attr('aria-expanded') === 'true';
    menu.attr('aria-expanded', !isMenuExpanded);
  }
}
