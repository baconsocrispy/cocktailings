import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Sorting Tabs Controller Loaded"); 
  }
}

$('.sorting-option').on('click', ({ target }) => {
  $('.sorting-option').each((_, option) => option.setAttribute('data-isSelected', false));
  target.setAttribute('data-isSelected', true);
});