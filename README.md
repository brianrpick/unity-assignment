# Unity SDET Test Assignment

This is a simple RESTful API made to be lightweight and easy to use. It runs on rails 5 and uses a txt file as a database.

### Prerequisites

* [Git](https://git-scm.com/)
* [Rails 5.0.x](http://rubyonrails.org/)

## Getting Started

1. First things first:
Please execute these commands in the terminal
```
$ git clone git@github.com:brianrpick/unity-assignment.git
$ cd unity-assignment
$ rails db:setup
$ bundle install
```

## Running the tests

RSpec Tests can be run inside the terminal by executing the following code

```
bundle exec rspec --tty spec/request/projects_controller_spec.rb
```

### Break down

These tests run Get/Post routes on the API. Heres an example of a test route:
```
(your local server)/api/v1/requestproject.json?country=YES
```