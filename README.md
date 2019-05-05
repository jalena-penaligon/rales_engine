# Project: Rales Engine

Welcome to Rales Engine, a JSON API designed to expose endpoints for customers, merchants, items, invoices, invoice items and transactions.

##Intent

This project was completed in 7 days as a requirement for Module 3.

The project was built using Rails which implements the following:

* Object oriented programming principles.
* Test Driven Development - TDD.
* Advanced database queries and calculations using ActiveRecord.
* FactoryBot to create objects for efficient testing.

##System Requirements

* Rails 5.x
* ActiveRecord - PostgreSQL.

## Gems Used

* Fast JSON API
* FactoryBot
* RSpec
* ShouldaMatchers
* Simplecov
* Pry

## Instructions
  ### How to setup:
      1. Clone the GitHub repository.
      2. cd rales_engine
      3. Run bundle install.
      4. Run rails import:sales_engine. This may take a few minutes to execute.

  ### Run tests:
        1. Run rspec.
        2. To run a single test, example: rspec ./spec/requests/api/v1/customers_request_spec.rb:25
        3. The above example can be edited to run spec folders and files.

  ### Run tests from the SpecHarness:
        1. From the rales_engine folder, run Rails s.
        2. Clone the GitHub repository: https://github.com/turingschool/rales_engine_spec_harness
        3. cd rales_engine_spec_harness
        4. Run bundle install
        5. Run bundle exec rake
