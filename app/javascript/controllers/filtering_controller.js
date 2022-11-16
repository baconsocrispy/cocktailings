import { Controller } from "@hotwired/stimulus";
import { getParams, reset, resetPage } from './helpers';

export default class extends Controller {
  // primary search / filtering handler
  filterRecipes() {
    const params = getParams();

    $.ajax({
      type: 'GET',
      dataType: 'html',
      url: '/recipes',
      data: params,
      success: function (response) {
        $('.recipe-cards').html(response);
        resetPage();
      }
    });
  }

  resetFilters() {
    reset();
    this.filterRecipes();
  }
}