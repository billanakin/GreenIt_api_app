# GreenIT API Server

A REST API Server for the GreentIT Project

## Development Setup

On your local machine, install the following:

- Ruby version 3.2.2
- PostgreSQL
- Redis

Then run the following command:

- `$ git clone git@github.com:billanakin/GreenIt_api_app.git`
- `$ cd GreenIt_api_app`
- `$ bundle install`
- `$ cp .env.sample .env`
- Populate the appropriate values in `$APP_DIR/.env`
- Then create the database via `$ ./bin/rails db:create db:migrate`
- `$ ./bin/rails s`

## Deployment

On a Linux Server, install the following:

- Nginx
- Passenger
- PostgreSQL
- Redis
