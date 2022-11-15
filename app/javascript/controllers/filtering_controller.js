import { Controller } from "@hotwired/stimulus";
import { getParams, resetValues } from './helpers';

export default class extends Controller {
  connect() {
  }

  // primary search / filtering handler
  filterRecipes(event) {
    event.preventDefault();

    const params = getParams(event);

    $.ajax({
      type: 'GET',
      dataType: 'html',
      url: '/recipes',
      data: params,
      success: function (response) {
        $('.recipe-cards').html(response);
        resetValues();
      }
    });
  }
}