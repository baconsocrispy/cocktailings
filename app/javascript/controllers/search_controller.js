import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  // connect() {
  //   $('#search-field').on('keyup', (e)=> {
  //     if (e.keyCode === 13) {
  //       e.preventDefault();
  //     }
  //   }, false);
  // }

  resetSearchValue(e) {
    e.preventDefault();
    const searchTerm = $('#search-field').val();

    $('#current-search').val(searchTerm);
    $('#search-field').val('');
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