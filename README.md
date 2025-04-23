# My Blogsite

## Technologies Used

- **Sinatra**: A DSL for quickly creating web applications in Ruby.
- **SQLite**: A lightweight database for storing and managing data.
- **Vue.js**: A progressive JavaScript framework for building user interfaces.
- **Docker**: Used for containerizing and deploying the application (planned for future implementation).

## Features

- **Admin Capabilities**: As an admin, you can create, edit, and delete posts.
- **User Access**: Users can read posts but have read-only access.


to run:
gem install bundler
bundle install
Create the .env file
bundle exec rake db:create
bundle exec rake db:migrate
ruby db/seeds.rb
ruby app.rb
or rackup
