# Tinyrails

A minimal Rails-like framework built from scratch to understand how Rails and other web frameworks operate under the hood.

## What it does

Tinyrails implements the core pieces of a web framework:

- **Rack integration** - Connects to web servers through the Rack interface
- **Routing** - Maps URLs to controller actions (e.g., `/tweets/show` routes to `TweetsController#show`)
- **Controllers** - Handle requests and render views with ERB templating
- **Models** - Basic JSON file-based persistence with find and query methods

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tinyrails'
```

Or install it directly:

```bash
gem install tinyrails
```

## How it works

### Controllers

Controllers inherit from `Tinyrails::Controller` and define action methods:

```ruby
class TweetsController < Tinyrails::Controller
  def show
    render :show
  end
end
```

The `render` method looks for views in `app/views/{controller_name}/{action}.html.erb`.

### Models

`FileModel` provides basic database operations using JSON files:

```ruby
# Find a record by ID
tweet = FileModel.find(1)

# Get all records
tweets = FileModel.all

# Access attributes
tweet["content"]
tweet["author"] = "New Author"
```

Records are stored as JSON files in `app/db/{table_name}/{id}.json`.

### Routing

The router parses the URL path to determine which controller and action to call:

- `/tweets/show` → `TweetsController#show`
- `/users/index` → `UsersController#index`

## Requirements

- Ruby >= 3.1.0

## License

MIT
