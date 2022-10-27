import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    document.addEventListener('scroll', this.scroll);
    console.log("Pagination Controller Loaded");
  }
  static values = {
    url: String,
    page: Number,
  };

  initialize() {
    this.scroll = this.scroll.bind(this);
    this.pageValue = this.pageValue || 1;
  }
  
  scroll() {
    if (this.scrollReachedEnd) {
      this._fetchNewPage();
    }
  }

  async _fetchNewPage() {
    const url = new URL(this.urlValue);

    url.searchParams.set('page', this.pageValue,);
    url.searchParams.append('ingredientIds', getIngredientIds());
    url.searchParams.append('recipeIds', getRecipeIds());
    url.searchParams.append('sort_option', $('.sort-options').val());

    console.log(getIngredientIds());

    await fetch(url.toString(), {
      headers: {
        Accept: 'text/vnd.turbo-stream.html',
      },
    }).then(r => r.text())
      .then(html => Turbo.renderStreamMessage(html));

    this.pageValue += 1;
    console.log(this.pageValue);
  }

  get scrollReachedEnd() {
    const { scrollHeight, scrollTop, clientHeight } = document.documentElement;
    const distanceFromBottom = scrollHeight - scrollTop - clientHeight;
    return distanceFromBottom < 1; // adjust the number yourself
  }
}

function getRecipeIds() {
  var recipeIds = [];
  $('.card').each(function () {
    recipeIds.push($(this).data('value'));
  });
  return recipeIds;
}

// gets selected ingredient ids from liquor cabinet display
// select options and returns them in an array
function getIngredientIds() {
  var ingredientIds = [...$('.cabinet-spirits').val(),
  ...$('.cabinet-modifiers').val(),
  ...$('.cabinet-sugars').val(),
  ...$('.cabinet-garnishes').val()];
  return ingredientIds;
}