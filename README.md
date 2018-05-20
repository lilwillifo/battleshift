# BattleShift

* An API for multi-player battleship.
* This is a brownfield project built on top of an existing battleship game for a single player and computer. Players sign up for an account, and will receive an email with their API key and a link to activate their account. Once activated, they are able to send post requests using their API key to create a new game, place their ships and fire shots on the opposing player.
* The deployed version can be found here: [BattleShift] (https://immense-woodland-83336.herokuapp.com/)
* The spec for this project can be found here: [Project Spec](http://backend.turing.io/module3/projects/battleshift)

## Getting Started

To run this application locally for testing and development, clone this repo and follow the steps below:

Bundle:
`$ bundle`

Set up the database:
`$ rake db:create`
`$ rake db:migrate`

Start up your rails server with `rails s`
and open localhost:3000 in your browser.

### Prerequisites

Ruby Version: 2.4+
Rails Version: 5+

## Running the tests

To run the test suite, run `rspec` from the root directory in your terminal after following the Getting Started instructions above.

## Built With

* [factorybot](https://github.com/thoughtbot/factory_bot)
* [shoulda matchers](https://github.com/thoughtbot/shoulda-matchers)
* [capybara](https://github.com/teamcapybara/capybara)
* The original brownfield application: [Original Battleshift](https://github.com/turingschool-examples/battleshift)
* The spec harness used to drive functionality: [Spec Harness](https://github.com/turingschool-examples/battleshift_spec_harness)

## Deployment
Visit the application deployed to Heroku [here](https://immense-woodland-83336.herokuapp.com/). Register for an account then check your email for your API key and account activation. This application requires [Postman](https://www.getpostman.com/) to post requests to the API.

## Authors
* [Margaret Williford](https://github.com/lilwillifo)
* [Megan Arellano](https://github.com/ssciolist)
