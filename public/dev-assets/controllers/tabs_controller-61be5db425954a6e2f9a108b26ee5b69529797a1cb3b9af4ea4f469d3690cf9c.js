import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  updateSortOption({ target }) {
    console.log('working');
    $('.sorting-option').each((_, option) => option.setAttribute('data-isSelected', false));
    target.setAttribute('data-isSelected', true);
  }
};
