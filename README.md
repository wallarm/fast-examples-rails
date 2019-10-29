# README

Example of integration Wallarm FAST with the rails app using FAST orb (plugin for CircleCI).

Orb is described here: 
https://circleci.com/orbs/registry/orb/wallarm/fast

## How to create test record locally

To use this example you will need to make a test_record.

Install docker

Get your UUID and Secret key:
https://docs.wallarm.com/en/admin-en/api-creds-en.html#get-your-uuid

Create your FAST node here:
https://my.wallarm.com/nodes

```sh
export WALLARM_API_TOKEN=<YOUR WALLARM NODE TOKEN>

sudo -E docker-compose build

# Run specs & record baselines. You will find test_record_id in logs. 
sudo -E docker-compose up -d fast selenium
sudo -E docker-compose run --use-aliases app-test bundle exec rspec spec/features/posts_spec.rb
sudo -E docker-compose down
```

## Intergation with Circle CI

Create a project and pass following ENV variables:
```
WALLARM_API_TOKEN <YOUR WALLARM NODE TOKEN>
```

Example builds:
https://circleci.com/gh/wallarm/fast-examples-rails/tree/orb_example


## Previous versions

In previous versions could be vary key principles which are used to integrate FAST with ci/cd processes.
Please read releases page.