# README

Example of integration Wallarm FAST with the rails app using rspec, capybara and selenium.

## How to run specs localy

Install docker and docker-compose

Get your UUID and Secret key:
https://docs.wallarm.com/en/admin-en/api-creds-en.html#get-your-uuid

Create your FAST node here:
https://my.wallarm.com/nodes

```sh
export TOKEN=<YOUR WALLARM NODE TOKEN>

sudo -E docker-compose build
sudo -E docker-compose up -d fast selenium
sudo -E docker-compose run --use-aliases app-test bundle exec rspec spec/features/posts_spec.rb
sudo -E docker-compose down
```

## Intergation with Circle CI

Create a project and pass following ENV variables:
```
TOKEN <YOUR WALLARM NODE TOKEN>
```

Example builds:
https://circleci.com/gh/wallarm/fast-examples-rails/
