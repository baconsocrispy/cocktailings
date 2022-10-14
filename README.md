# README

## Introduction

I created this app to fool around a bit with Rails 7 and maybe create something useful. 
As of October, 2022 it is still a work in progress. The end goal is an application that 
allows a user to enter the contents of their liquor cabinet and recieve a list of 
cocktail recipes that they can make from that collection. 

## System / Gem Dependencies

* Ruby version 3.1.2
* Rails version 7.0.4
* pg 1.4.3
* Bootstrap 5.2.1
* jQuery 3.6.0
* cocoon 1.2.15
* simple_form 5.1.0
* devise 3.8.1

### Ruby

#### INSTALLING ASDF FROM TERMINAL: 
Use asdf to install ruby as it allows for easier switching between ruby versions
than rbenv and other package managers. 

* Install using homebrew: brew install asdf
* Add this to ~/.zshrc file (open ~/.zshrc): `. /opt/homebrew/opt/asdf/libexec/asdf.sh`
* Add asdf ruby plugin: `asdf plugin add ruby`
* List all available ruby versions with: `asdf list all ruby`

#### INSTALLING LATEST RUBY VERSION WITH ASDF: 

* Install from terminal: `asdf install ruby latest`
* If necessary, uninstall rbenv: `brew remove rbenv`
* Will need to remove the .rbenv directory: `r```m -rf ~/.rbenv\`
* Delete references to rbenv from ~/.zshrc
* Set global ruby version for mac (adds it to ~/.tool-version file): `asdf global ruby 3.1.2`

Resources:
* https://mac.install.guide/ruby/6.html
* https://asdf-vm.com/guide/getting-started.html
* https://stackoverflow.com/questions/31173968/how-do-you-uninstall-rbenv-on-macos

### Rails / PostgreSQL

#### INSTALL & INITIALIZE RAILS:

Install rails: `gem install rails`

#### INSTALL POSTGRESQL
I used Postgres for the database in this application.

To install Postgresql@14: `brew install postgresql@14`

#### CREATING A RAILS APP WITH POSTGRES DB

* Create new rails app with postgres db: `rails new app_name --database=postgresql`
* cd into the new rails app parent folder
* run bundle install: `bundle install`
* Create database: `rails db:create`
* Run migrations: `rails db:migrate`
* Add db credentials to database.yml

Troubleshooting:
I got this error running bundle install: An error occurred while installing pg (1.4.3), and Bundler cannot continue.

Solved it with this: `gem install pg -- --with-pg-config=/Applications/Postgres.app/Contents/Versions/latest/bin/pg_config`

### ADDING DEPENDENT GEMS / IMPORTMAP CONFIGURATION
Rails 7 prefers importmap implementation over yarn/gem/webpacker. This involves
pinning cdn paths to the importmap.rb file in the config folder.

#### JQUERY / JQUERY-UI / STIMULUS JS

* Add this to importmap.rb: `pin "jquery", to: "https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.js"`
* Add jQuery to top of application.js file: `import 'jquery'`
* NOTE: jQuery must be imported before other libraries or it won't function properly
* Rails 7 relies on Stimulus JS controllers. They are saved as follows: /javascript/controllers: controllerName_controller.js
* Add controller to HTML element attributes: `data-controller='controllerName'`
* Add controller action: `data-action='controllerName#controllerAction'`
* application.js must have: `import: 'controllers' and import '@hotwired/turbo-rails'`

#### BOOTSTRAP

* To add bootstrap to importmap, run following in terminal: `bin/importmap pin bootstrap`
* Then import bootstrap in application.js: `import 'bootstrap'`
* Use Unpkg for popper to avoid glitches with jspm: "https://unpkg.com/@popperjs/core@2.11.6/dist/esm/index.js"
* Add bootstrap gem to gemfile and bundle install: `gem 'bootstrap'`
* Change application.css to application.scss and import bootstrap: `import 'bootstrap'`;

Help from here: https://blog.eq8.eu/til/how-to-use-bootstrap-5-in-rails-7.html

## NESTED FORMS
The cocktail recipe requires multiple nested forms inside the recipe form to generate
associated recipe steps, tools, and ingredients (portions in this app). I used simple_form and
the cocoon app to streamline this process

* Add the cocoon gem to the gemfile: `gem cocoon`
* Add the simple_form gem to gemfile: `gem simple_form`
* bundle install: `bundle install`

## ACTIVE STORAGE
To store images you need to install rails active storage:

* To install: `rails active_storage:install`
* Migrate DB: `rails db:migrate`
* Declare storage services in config/storage.yml
* Tell Active Storage which service to use in config/environments, add this line 
to relevant environment.rb: `config.active_storage.service = :local` (but specify other service if not local)

## USER AUTHENTICATION / AUTHORIZATION
I'm using the devise gem to handle user authentication in the app. There are 
complications with Turbo in Rails 7 that prevent flash messages from displaying 
properly. I found excellent help from the article by Nick Francisci below. 

INSTALL /CONFIGURE LATEST DEVISE GEM

`bundle add devise`

Don't forget to add `before_action :authenticate_user!` to relevant controllers

Help from: 
* https://betterprogramming.pub/devise-auth-setup-in-rails-7-44240aaed4be
* Devise Docs: https://github.com/heartcombo/devise

