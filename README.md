# Search Engine API

### Overview
The project is a web scrapping app to fetch text on google, bing or any other search engine, parse the HTML result and provide a JSON response as an API.
It was built using Ruby 3.1.4 and Rails 6.1.7 as a back-end (API only) application.

It implements a single API request in controller **search**, for instance the params received are:
 - engines: string array. ex: ['google', 'bing']
 - query: string. ex: 'test text'

Expected response:
 - It should returned a parsed response in JSON format, as described below:
 ```
  {
    engine: string,
    title: string,
    link: string,
    body: string
  }
 ```
  - If query parameters contains multiple engines, then it should aggregate results from all engines provided


### How to run
- To build the docker container, type: `$ docker-compose build`
- To run the rails server, type: `$ docker-compose up`
- To run all test cases, type: `$ docker-compose run web rspec .`
- To run the rubocop linter, type: `$ docker-compose run web rubocop`
- To enter in the rails console, type: `$ docker-compose run web rails c`
