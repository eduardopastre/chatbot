![alt text](https://www.dropbox.com/s/2hyytvhcyzta90o/chatbot.gif?raw=1) 
# Chatbot

Project developed in Bootcamp OneBitCode

- This project create a bot to manage a basic sistem of Faq. The user can interact with bot to create, list and remove Faqs, too is possible to favor Faqs. The project provides a webhook that can be integrate with Api.ai.

## Pré-requisits

* Sinatra
* Ruby version - 2.3.6
* Database - Postgres

## Running with Docker

It's very easy.
* Install docker and docker-compose in your machine
* Run _docker-compose build_ to prepare the project and _docker-compose up_
* Access http://localhost:3000 if the 'Hello world!' message appear in your browser, that's all ok!
* The webhook is available in /webhook route with POST method

## Tests executing

Tests were written with Rspec, to execute then do:
* _docker-compose run --rm website bundle exec rspec spec_