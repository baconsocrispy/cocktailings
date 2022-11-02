import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Categories Controller Loaded");
  }

  toggleCategoryMenu() {
    const menu = $('.category-toggle');
    let isMenuExpanded = menu.attr('aria-expanded') === 'true';
    menu.attr('aria-expanded', !isMenuExpanded);
  }
}
