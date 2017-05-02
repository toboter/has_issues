## Installation
Add this line to your application's Gemfile:

```ruby
gem 'has_issues', git: 'git://github.com/toboter/has_issues.git'
```


And then execute:
```bash
$ bundle
```

  Run the following command to copy has_issues's initializer and migration to your app:

  ```sh
  $ rake has_issues:install
  ```

  Or alternatively:

  ```sh
  $ rake has_issues:install:initializers

  $ rake has_issues:install:migrations
  ```

  And then execute:

  ```sh
  $ rake db:migrate
  ```


## Usage

Current User object
```erb
  acts_as_issuer
```
has to be added to the current_user model and there should be a current_user initializer with

```ruby
ActionController::Base.class_exec do
  helper_method :current_user

  def current_user
    @current_user ||= User.first
  end
end
```

Models
```erb
  acts_as_issueable
```
has to be added


Routes
HasIssues has to be mounted anywhere you like to add issues. 
```ruby
  mount HasIssues::Engine, at: "/"
```

Views

```erb
  <%= yield :title %> 
```
needs to be specified in application.html.erb 's head.

Button to Issues index page
```erb
  <%= has_issue_track(@subject) %>
```

Link to all issues index page
```erb
  <%= link_to 'all issues', all_issues_path %>
```


## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).