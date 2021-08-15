# Search Engine API

### Overview
The project serves to search some text on google or bing engines, parse the HTML result and provide a JSON response as an API.
It was built using Ruby 2.5.9 and Rails 5.2.6 as a back-end (API only) application.

**Container:** To avoid environment issues, I created a *Dockerfile* to setup locally, just be sure you have those dependency installed on you machine.

**CI:** When a new *push* is triggered on *main* branch, an automated CI pipeline runs using GitHub Actions validating all tests (rspec) and linter (rubocop).

### How to run
- To build the docker container, type: `$ docker-compose build`
- To run the rails server, type: `$ docker-compose up`
- To run all test cases, type: `$ docker-compose run web rspec .`
- To run the rubocop linter, type: `$ docker-compose run web rubocop`
- To enter in the rails console, type: `$ docker-compose run web rails c`
