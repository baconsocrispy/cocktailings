import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  appendIngredient() {
    const tr = $('.portions .nested-fields').remove();
    const type = tr.data('ingredient-type');
    console.log(tr);

    tr.appendTo(`#${ type.toLowerCase() }-ingredients`);
    console.log(tr.children().children());
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