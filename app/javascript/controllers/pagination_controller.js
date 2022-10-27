import { Controller } from "@hotwired/stimulus";

const spinner = `
  <div class='col-span-12 container mx-auto h-24 mb-8' id='spinner'>
    <div class='loader'>Loading...</div>
  </div>`;

export default class extends Controller {
  connect() {
    console.log("Recipes Controller Loaded");

    document.addEventListener('scroll', this.scroll);
  }

  static fetching = false;

  static values = {
    url: String,
    page: { type: Number, default: 1 },
  };

  static targets = ['recipes', 'noRecords']

  initialize() {
    this.scroll = this.scroll.bind(this);
  }

  scroll() {
    if (this.pageEnd && !this.fetching && !this.hasNoRecordsTarget) {
      // add spinner to end of page
      this.recipesTarget.insertAdjacentHTML('beforeend', spinner);

      this.loadRecords();
    }
  }

  async loadRecords() {
    var url = new URL(this.urlValue);
    url.searchParams.set('page', this.pageValue);

    this.fetching = true;

    await fetch(url.toString(), {
      responseKind: 'turbo-stream',
    });

    this.fetching = false;

    this.pageValue += 1;
  }

  get pageEnd() {
    const { scrollHeight, scrollTop, clientHeight } = document.documentElement;
    return scrollHeight - scrollTop - clientHeight < 40; // can adjust to desired limit
  }
}

