# GraphQL::AnonymousOperationRejector

[![Gem](https://img.shields.io/gem/v/graphql-anonymous_operation_rejector.svg)](https://rubygems.org/gems/graphql-anonymous_operation_rejector)
[![Build Status](https://travis-ci.org/increments/graphql-anonymous_operation_rejector.svg?branch=master)](https://travis-ci.org/increments/graphql-anonymous_operation_rejector)
[![Code Climate](https://codeclimate.com/github/increments/graphql-anonymous_operation_rejector/badges/gpa.svg)](https://codeclimate.com/github/increments/graphql-anonymous_operation_rejector)
[![Test Coverage](https://codeclimate.com/github/increments/graphql-anonymous_operation_rejector/badges/coverage.svg)](https://codeclimate.com/github/increments/graphql-anonymous_operation_rejector/coverage)
[![license](https://img.shields.io/github/license/increments/graphql-anonymous_operation_rejector.svg)](https://github.com/increments/graphql-anonymous_operation_rejector/blob/master/LICENSE)

An GraphQL analyzer to reject anonymous operation.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'graphql-anonymous_operation_rejector', require: 'graphql/anonymous_operation_rejector'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install graphql-anonymous_operation_rejector

## Usage

```rb
class MySchema < GraphQL::Schema
  query_analyzer GraphQL::AnonymousOperationRejector.new
  query Types::Query
end
```

Now `MySchema` accepts GraphQL queries with operation name only:

```rb
MySchema.execute('query { hello }').to_h
#=> { "error": [{ "message" => "Anonymous operation is not allowed. Please add operation name to your query." }]}

MySchema.execute('query thisIsOperationName { hello }').to_h
#=> { "data": { "hello" => "world" } }
```

Read also: [GraphQL - Ahead-of-Time Analysis](http://graphql-ruby.org/queries/analysis.html)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/increments/graphql-anonymous_operation_rejector. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Graphql::AnonymousOperationRejector project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/increments/graphql-anonymous_operation_rejector/blob/master/CODE_OF_CONDUCT.md).
