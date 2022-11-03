import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    // lets me know controller is function properly
    console.log("Cabinets Controller Loaded");

    // closes cabinet menu when clicking elsewhere on the page
    $(document).on('click', ({ target }) => {
      if (target.classList.contains('toggle-cabinet-menu')) return;
      if ($('.toggle-cabinet-menu').attr('aria-expanded') === 'true') {
        $('.toggle-cabinet-menu').attr('aria-expanded', false);
      }
    });

    // adds onClick listener for when user changes the current cabinet
    $(document).on('click', '.cabinet-option', changeLiquorCabinet);
  }

  // opens/closes liquor cabinet menu when '+' icon is clicked
  toggleCabinetMenu() {
    const menu = $('.toggle-cabinet-menu');
    let isMenuExpanded = menu.attr('aria-expanded') === 'true';
    menu.attr('aria-expanded', !isMenuExpanded);
  }
}

// reloads liquor cabinet display with selected liquor cabinet
function changeLiquorCabinet(e) {
  var cabinet_id = $(e.target).val();
  $.ajax({
    type: 'GET',
    dataType: 'html',
    data: { update_id: cabinet_id },
    url: $(e.target).data('url'),
    success: function (response) {
      $('.liquor-cabinet-display').html(response);
    }
  });
}