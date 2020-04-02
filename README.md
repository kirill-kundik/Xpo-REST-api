# xpo-backend

### Installing dependencies:
1. Clone this repo `git clone <repo_url>`
1. Install [postgres](https://postgresql.org)
1. Install dependencies `bundle install`

### Deployment instructions:

1. Check if postgres instance is available.
1. Create database: `rake db:create`
1. Run migrations: `rake db:migrate`
* To start development server: `rails server webrick -b 127.0.0.1 -p 3000 -e development`, you may want to change 'development' -> 'test'.
* To start production Puma server: `rails server Puma -b 127.0.0.1 -p 3000 -e production`

***

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
