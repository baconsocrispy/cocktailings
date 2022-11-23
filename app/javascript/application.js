// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

// jquery libraries - need to import first
import "jquery"; 
import 'jquery-ui-dist';

// fontawesome fonts for favoriting icons
import '@fortawesome/fontawesome-free';

// stimulus / turbo libraries
import "@hotwired/turbo-rails";
import "controllers";

// bootstrap
import 'bootstrap';

// manually import cocoon js (see javascript/gems/cocoon.js)
import './gems/cocoon.js';

import 'sortablejs';