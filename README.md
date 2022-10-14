# README

* Introduction

I created this app to fool around a bit with Rails 7 and maybe create something useful. 
As of October, 2022 it is still a work in progress. The end goal is an application that 
allows a user to enter the contents of their liquor cabinet and recieve a list of 
cocktail recipes that they can make from that collection. 

* System / Gem Dependencies

Ruby version 3.1.2
Rails version 7.0.4
pg 1.4.3
Bootstrap 5.2.1
jQuery 3.6.0
cocoon 1.2.15
simple_form 5.1.0

* Ruby

INSTALLING ASDF FROM TERMINAL: 
Use asdf to install ruby as it allows for easier switching between ruby versions
than rbenv and other package managers. 

Install using homebrew: brew install asdf
Add this to ~/.zshrc file (open ~/.zshrc): `. /opt/homebrew/opt/asdf/libexec/asdf.sh`
Add asdf ruby plugin: `asdf plugin add ruby`
List all available ruby versions with: `asdf list all ruby`

INSTALLING LATEST RUBY VERSION WITH ASDF: 

Install from terminal: `asdf install ruby latest`
If necessary, uninstall rbenv: `brew remove rbenv`
Will need to remove the .rbenv directory: `r`````m -rf ~/.rbenv\`
Delete references to rbenv from ~/.zshrc
Set global ruby version for mac (adds it to ~/.tool-version file): `asdf global ruby 3.1.2`
Resources:
-https://mac.install.guide/ruby/6.html
-https://asdf-vm.com/guide/getting-started.html
-https://stackoverflow.com/questions/31173968/how-do-you-uninstall-rbenv-on-macos

* Rails

INSTALL RAILS:

`gem install rails`

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


STIMULUS
Troubleshooting: Struggled half a day to get Stimulus Controllers to respond
Not sure what prompted it to start working, but created a new controller using:
rails g stimulus controllerName
and moved the jquery import statement to the top of the application.js import list

SINGLE TABLE INHERITANCE vs. POLYMORPHIC
Started with polymorphic relationship between ingredient types, but refactored
for STI. Code felt cleaner and that way all ingredients have a unique id. PM might
have been better if the database of ingredients was expected to be enormous and
multiple tables might have sped up search, but can't imagine there will be more 
than a few thousand potential ingredients.

RAILS AJAX 
This article was very helpful to understanding the rails ajax methodology, 
making async calls to controller methods from the view without needing javascript.
https://medium.com/@codenode/how-to-use-remote-true-to-make-ajax-calls-in-rails-3ecbed40869b



POSTGRESQL
Using Postgresql@14: brew install postgresql@14
Create database: rails db:create
Run migrations: rails db:migrate
Add db credentials to database.yml: might need to use 

Troubleshooting:
Got this error running bundle install: An error occurred while installing pg (1.4.3), and Bundler cannot continue.

Solved it with this: gem install pg -- --with-pg-config=/Applications/Postgres.app/Contents/Versions/latest/bin/pg_config
