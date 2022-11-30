import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    // closes cabinet menu when clicking elsewhere on the page
    $(document).on('click', ({ target }) => {
      if (target.classList.contains('toggle-cabinet-menu')) return;
      if ($('.toggle-cabinet-menu').attr('aria-expanded') === 'true') {
        $('.toggle-cabinet-menu').attr('aria-expanded', false);
      }
    });
  }

  // reloads cabinet sidebar with selected liquor cabinet
  changeCabinet(e) {
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

  async updateMobileCabinet({ target }) {
    const url = target.getAttribute('data-url');
    const configuredUrl = new URL(url);
    await fetch(configuredUrl, {
      headers: {
        Accept: 'text/vnd.turbo-stream.html',
      },
    }).then(r => r.text())
      .then(html => Turbo.renderStreamMessage(html));
    
    $('#mobile-change-cabinet').hide();
    $('#mobile-cabinet-menu').show();
  }

  // opens/closes cabinet menu when '+' icon is clicked
  toggleCabinetMenu() {
    const menu = $('.toggle-cabinet-menu');
    let isMenuExpanded = menu.attr('aria-expanded') === 'true';
    menu.attr('aria-expanded', !isMenuExpanded);
  }

  // opens/closes cabinet menu when '+' icon is clicked
  toggleCabinetNavMenu() {
    const menu = $('.nav-list-container');
    let isMenuExpanded = menu.attr('aria-expanded') === 'true';
    menu.attr('aria-expanded', !isMenuExpanded);
  }
}

