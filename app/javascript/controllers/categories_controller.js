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

    // priority navigation bar controls
    $(document).ready(() => {
      var item_width = $('.category-item').width();
      var item_count = $('#category-items .category-item').length;

      var nav_width_og = $('#category-items').width();
      var nav_width = $('#category-items').width();

      var isOverflowing = nav_width < (item_width * item_count);
      

      // if (isOverflowing) {
      //   $('#more-categories').appendTo('body');
      //   $('#more-categories').hide();
      // }

      for (var i = 0; i < item_count; i++) {
        item_count = $('#category-items .category-item').length;

        if (isOverflowing) addCategoryToOverflow();
      }

      $(window).resize(() => {
        nav_width = $('#category-items').width();
        item_width = $('.category-item').width();
        item_count = $('#category-items .category-item').length;

        isOverflowing = nav_width < (item_width * item_count);

        if (isOverflowing) addCategoryToOverflow();

        if (nav_width > (item_width * item_count) + (item_width - 1)) {
          $('#category-overflow li').last().appendTo($('#category-items'));
          $('#more-categories').appendTo($('#categories-container'));
        }

        if (nav_width == nav_width_og) {
          $('#more-categories').appendTo('body');
          $('#more-categories').hide();
        }
      });

      $('#more-categories').on('click', () => {
        $('#category-overflow').slideToggle();
      });
    });
  }

  toggleCategoryMenu() {
    const menu = $('.category-toggle');
    let isMenuExpanded = menu.attr('aria-expanded') === 'true';
    menu.attr('aria-expanded', !isMenuExpanded);
  }
}

function addCategoryToOverflow() {
  $('#category-items .category-item')
    .last()
    .appendTo($('#category-overflow'));

  // $('#more-categories').appendTo($('#categories-container'));
  // $('#more-categories').show();
}