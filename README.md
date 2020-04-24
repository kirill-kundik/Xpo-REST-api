# xpo-backend

Public api available at: https://xpo.restful-api.site

How to use api you can check from `doc/xpo.postman_collection.json`

### Installing dependencies:
1. Clone this repo `git clone <repo_url>`
1. Create `.env` file (`touch .env`)
1. Generate new secret `bundle exec rake secret`
1. Create `DEVISE_SECRET_KEY` variable in `.env` file with value from previous step
1. Create `RAILS_ENV` variable in `.env` with value `production` or `development`

### Installing dependencies part 2 (non-Docker users):
1. Install [postgres](https://postgresql.org)
1. Install [redis](https://redis.io)
1. Install dependencies `bundle install`

### Installing dependencies part 2 (Docker users):
1. Check [Docker](https://www.docker.com/) and [docker-compose](https://docs.docker.com/compose/install/) installations
1. Run `docker-compose build` for building app image

### Deployment instructions (non-Docker users):

1. Check if postgres instance is available (start cmd: `systemctl start postgres` or `brew services start postgres`)
1. Check if redis instance is available (start cmd: `redis-server`)
1. Create and setup database: `rake db:{create,setup}`
1. Start the sidekiq: `sidekiq -e $RAILS_ENV`
* To start development server: `rails server webrick -b 127.0.0.1 -p 3000 -e development`
* To start production Puma server: `rails server Puma -b 127.0.0.1 -p 3000 -e production`

### Deployment instructions (Docker users):
1. Up postgres service `docker-compose up db redis`
1. (Optional, if needed) Run db setup: `docker-compose run web rake db:{create,setup}`
1. Start the sidekiq: `docker-compose up sidekiq`
1. To start server: `docker-compose up web`

***

* To stop server for non-Docker users: `CTRL+C`
* To stop server for Docker users: `docker-compose stop` or `docker-compose down` for stopping and removing all containers/networks/volumes that were created to start the app.