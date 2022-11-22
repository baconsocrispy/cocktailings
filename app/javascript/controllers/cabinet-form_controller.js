import { Controller } from "@hotwired/stimulus";
import { formatIngredientDisplay } from "./helpers";

export default class extends Controller {
  appendIngredient() {
    const ingredient_form = $('.portions .nested-fields').remove();
    const type = ingredient_form.data('ingredient-type');

    ingredient_form.appendTo(`#${ type.toLowerCase() }-ingredients`);

    formatIngredientDisplay(ingredient_form);
  }

  updateType({ target }) {
    $.ajax({
      type: 'GET',
      url: target.getAttribute('data-url'),
      dataType: 'json',
      data: { 'ingredientId': target.value },
      success: ({ ingredientType }) => {
        target
          .closest('.nested-fields')
          .setAttribute('data-ingredient-type', ingredientType);
      }
    });
  }
}

