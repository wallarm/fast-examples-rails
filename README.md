# README

This is example of integration Wallarm FAST with the rails app using rspec, capybara and selenium.

Build without vuln (should be success): [![CircleCI](https://circleci.com/gh/wallarm/fast-examples-rails/tree/master.svg?style=svg)](https://circleci.com/gh/wallarm/fast-examples-rails/tree/master)

Build with vuln (should fail): [![CircleCI](https://circleci.com/gh/wallarm/fast-examples-rails/tree/feature%2Fvuln.svg?style=svg)](https://circleci.com/gh/wallarm/fast-examples-rails/tree/feature%2Fvuln)

## How to run specs localy

Install docker and docker-compose

Get your UUID and Secret key:
https://docs.wallarm.com/en/admin-en/api-creds-en.html#get-your-uuid

Create your FAST node here:
https://my.wallarm.com/nodes

```sh
export WALLARM_API_TOKEN=<YOUR WALLARM NODE TOKEN>

sudo -E docker-compose build

# Run specs & record baselines
sudo -E docker-compose up -d fast selenium
sudo -E docker-compose run --use-aliases app-test bundle exec rspec spec/features/posts_spec.rb
sudo -E docker-compose down

# Run security specs based on recorded baselines
sudo -E docker-compose up -d app-test
sudo -E docker-compose run --rm -e CI_MODE=testing -e TEST_RUN_URI=http://app-test:3000 fast
sudo -E docker-compose down
```

## Intergation with Circle CI

Create a project and pass following ENV variables:
```
WALLARM_API_TOKEN <YOUR WALLARM NODE TOKEN>
```

Example builds:
https://circleci.com/gh/wallarm/fast-examples-rails/


## Previous versions

In previous versions could be vary key principles which are used to integrate FAST with ci/cd processes.
Please read releases page.
