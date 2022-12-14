import { Controller } from "@hotwired/stimulus";
import { configureUrl } from "./helpers";

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

  static get targets() { return ['recipes', 'noRecords']; }

  // adds the scroll event listener and sets fetching flag to false
  connect() {
    document.addEventListener('scroll', this.scroll);
    this.fetching = false;
  }

  // binds this to the controller rather than document
  initialize() {
    this.scroll = this.scroll.bind(this);
  }

  // calls loadRecords() when scroll reaches the bottom of the page
  // $.active == 0 tests whether there are any active ajax requests
  // which helped prevent multiple new page requests from getting called
  // at once
  scroll() {
    if (this.pageEnd && !this.fetching && !this.hasNoRecordsTarget && $.active == 0) {
      this.loadRecords(); 
    }
  }

  // record fetching function
  async loadRecords() {
    // get pre-configured url from helper method
    const url = configureUrl(this.urlValue, this.pageValue);
    
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

    // sets fetching flag to false
    this.fetching = false;
  }

  // sets the boundary where the loadRecords() function gets called
  get pageEnd() {
    const { scrollHeight, scrollTop, clientHeight } = document.documentElement;
    return scrollHeight - scrollTop - clientHeight < 10; // can adjust to desired limit
  }
}