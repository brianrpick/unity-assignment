# Unity SDET Test Assignment

This is a simple RESTful API made to be lightweight and easy to use. It runs on rails 5 and uses a txt file as a database. You can create a 'project' that contains informaton which is stored in the txt file called 'projects.txt'. The project 'model' contains:
```
id
projectname
creationdate
exirydate (expiration date)
enabled (default to true)
targetcountries
projectcost
projecturl
targetkeys
```
*This version of the API is only accepting single parameter querys*

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
$ rails s
```
And let the fun begin!

## Running the tests

Test collection provided through Postman

```
https://www.getpostman.com/collections/5e7c9ba3c03bc0e8c60d
```

### Break down

These tests run Get/Post routes on the API. Heres an example of a test route:
```
(your local server)/api/v1/requestproject.json?country=YES
```