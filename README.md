# Ruby On Rails Tutorial: Sample App

This is the sample application for the [*Ruby on Rails Tutorial: Learn Web Development with Rails*](http://www.railstutorial.org/) by [Michael Hartl](http://www.michaelhartl.com/).

Some modifications where made to this tutorial, like using the testing framework [Rspec](https://github.com/rspec/rspec-rails) among with [Faker](https://github.com/stympy/faker) instead of Test::Unit, the use of [RuboCop](https://github.com/bbatsov/rubocop) Ruby static code analyzer.

The app is hosted in [Heroku](https://www.heroku.com/platform), and you can find it [here](https://prudi-sample-app.herokuapp.com/).

## Users

The users of the app can be found in the *db/seed.rb* file.

**Admin User**
*email: user@example.com*
*password: password*

**Common User**
*email: user-1@example.com*
*password: password*

## Notes

- Email sending as is not implemented in production enviroment
- Image upload is yet not implemented with Amazon S3
