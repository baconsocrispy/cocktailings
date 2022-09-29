# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Introduction
Created this app to experiment with Rails 7, Ruby 3, and integrate jQuery, Bootstrap,
Nested Form Submission, 

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* JQUERY
Rails 7 prefers importmap implementation over yarn/gem/webpacker
Add this to importmap.rb: pin "jquery", to: "https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.js"
Create a JavaScript controller in /javascript/controllers: controllerName_controller.js
Import jQuery in controller file: import 'jquery'
Add controller to HTML element attributes: data-controller='controllerName'
application.js must have: import: 'controllers' and import '@hotwired/turbo-rails'

* NESTED FORMS
Update multiple models from one form. 
Using turbo-frame to dynamically add recipe steps when making a new recipe.

* BOOTSTRAP
To add bootstrap to importmap, run following in terminal: bin/importmap pin bootstrap
Then import bootstrap in application.js: import 'bootstrap'
Use Unpkg for popper to avoid glitches with jspm: "https://unpkg.com/@popperjs/core@2.11.6/dist/esm/index.js"
Add bootstrap gem to gemfile and bundle install: gem 'bootstrap';
Change application.css to application.scss and import bootstrap: @import 'bootstrap';
Help from here: https://blog.eq8.eu/til/how-to-use-bootstrap-5-in-rails-7.html

ACTIVE STORAGE
To store images you need to install rails active storage:
To install: rails active_storage:install
Migrate DB: rails db:migrate
Declare storage services in config/storage.yml
Tell Active Storage which service to use in config/environments, add this line to relevant environment.rb: config.active_storage.service = :local (but specify other service if not local)
Troubleshooting: 
Was getting this error from vie when a record did not have an image attachment: Can't resolve image into URL: undefined method `persisted?' for nil:NilClass
Resolved by checking for image presence:
    <% if recipe.image.present? %>
      <%= image_tag recipe.image %>
    <% end %>

