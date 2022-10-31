import { Controller } from "@hotwired/stimulus";

export default class extends Controller {

  // gets/sets record fetching flag
  static get fetching() { return this.fetching; }
  static set fetching(bool) {
    this.fetching = bool;
  } 

  // gets url and page number from target element
  static get values() { return {
    url: String,
    page: { type: Number, default: 1 },
  };}

  // adds the scroll event listener and sets fetching flag to false
  connect() {
    console.log("Pagination Controller Loaded");
    document.addEventListener('scroll', this.scroll);
    this.fetching = false;
  }

  // binds this to the controller rather than document
  initialize() {
    this.scroll = this.scroll.bind(this);
  }

  // calls loadRecords() when scroll reaches the bottom of the page
  scroll() {
    if (this.pageEnd && !this.fetching) {
      this.loadRecords(); 
    }
  }

  // record fetching function
  async loadRecords() {
    // get pre-configured url from helper method
    const url = getUrl(this.urlValue, this.pageValue);
    
    // sets fetching flag to true
    this.fetching = true;

    // sends a turbo_stream fetch request to the recipes controller
    await fetch(url, {
      headers: {
        Accept: 'text/vnd.turbo-stream.html',
      },
    }).then(r => r.text())
      .then(html => Turbo.renderStreamMessage(html));

    // increments the target element's page number
    this.pageValue += 1;
    console.log(this.pageValue);

    // sets fetching flag to false
    this.fetching = false;

  }

  // sets the boundary where the loadRecords() function gets called
  get pageEnd() {
    const { scrollHeight, scrollTop, clientHeight } = document.documentElement;
    return scrollHeight - scrollTop - clientHeight < 40; // can adjust to desired limit
  }
}

//  -------------  HELPER FUNCTIONS ----------------

// gets selected ingredient ids from liquor cabinet display
// options and returns them in an array
function getIngredientIds() {
  var ingredientIds = [...$('.cabinet-spirits').val(),
  ...$('.cabinet-modifiers').val(),
  ...$('.cabinet-sugars').val(),
  ...$('.cabinet-garnishes').val()];
  return ingredientIds;
}

// if there are ingredientIds, appends them as an array to searchParams
function appendIngredientIds(url) {
  var ingredientIds = getIngredientIds();
  if (ingredientIds.length != 0) {
    ingredientIds.map(i => url.searchParams.append('ingredientIds', i));
  }
  return url;
}

// configures url searchParams and returns the url
function getUrl(urlValue, pageValue) {
  var url = new URL(urlValue);
  url.searchParams.set('page', pageValue);
  url.searchParams.append('sort_option', $('.sort-options').val());
  url = appendIngredientIds(url);
  return url.toString();
}