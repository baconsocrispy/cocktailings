import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    // closes the mobile keyboard when return/enter is pressed
    $('.search-field').on('keyup', (event) => {
      const key = event.code || event.keyCode;
      if (key === 'Enter' || key === 13) {
        $(this).blur();
      }
    });
  }

  resetSearchValue(e) {
    e.preventDefault();
    const searchTerm = $('.search-field').val();

    $('.current-search').val(searchTerm);
    $('.search-field').val('');
    $('#search-term').html(searchTerm);

    toggleCurrentSearch(searchTerm);

    return searchTerm;
  }
}

function toggleCurrentSearch(searchTerm) {
  var searchContainer = document.querySelector('#search-term-container');
  const isBlank = (searchTerm == '');

  if (isBlank)  
    { searchContainer.setAttribute('data-hidden', true); } 
  else 
    { searchContainer.setAttribute('data-hidden', false); }
}