# Ruby coding standards

Use the latest version of Ruby 2.4 when starting a new project.

We follow the [Ruby style guide](https://github.com/bbatsov/ruby-style-guide).

## Checking your code style

Include [defra-ruby-style](https://github.com/DEFRA/defra-ruby-style) in your Ruby projects. We built this gem to check and enforce code style.

Once you have the gem installed, you can check your code for issues by running `bundle exec rubocop`. If you have a linter in your text editor, it will also use the gem.

Include `bundle exec rubocop` in your CI, and the build will fail if there are any style violations.

## Tools

Use [Hakiri](https://hakiri.io/) to check for vulnerabilities in your project and dependencies. Integrate it through GitHub and it will check new commits and PRs.

## Rails

Use Rails 4.2 when starting a new project.

We follow [Rails best practice](https://github.com/bbatsov/rails-style-guide).
