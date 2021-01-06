# HumanizedId

[![Gem Version](https://badge.fury.io/rb/humanized_id.svg)](https://badge.fury.io/rb/humanized_id)
[![Build Status](https://github.com/sealink/humanized_id/workflows/Build%20and%20Test/badge.svg?branch=master)](https://github.com/sealink/humanized_id/actions)
[![Coverage Status](https://coveralls.io/repos/github/sealink/humanized_id/badge.svg?branch=master)](https://coveralls.io/github/sealink/humanized_id?branch=master)
[![Code Climate](https://codeclimate.com/github/sealink/humanized_id/badges/gpa.svg)](https://codeclimate.com/github/sealink/humanized_id)

HumanizedId is a gem designed to help you either:

- Convert an existing numerical id into a 'human friendly' alphanumerical id
- Generate a random 'human friendly' id that is of a specified or default length

A 'humanized' (or 'human friendly') id is an id that is easy to read and is based
off a character set that does not allow vague or vulgar references.

## Installation

Add this line to your application's Gemfile

```ruby
gem 'humanized_id'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install humanized_id

## Usage

### Humanize an existing id

The simplest way to call humanize is to pass in an existing numerical id, and let HumanizedId return a human friendly version of that id. This id will be shorter in length (due to base conversion) and will be an alphanumerical string based on a 'human safe' character-set.

```ruby
humanized_id = HumanizedId.humanize id: 1234567
# Returns '6RDFD'
```

#### Ensuring minimum length of output id

An optional min_length flag can be passed in order to guarantee the minimum length of the returned value. This will be done by 'padding' the return id with the safe-charset default value '2'.

```ruby
humanized_id = HumanizedId.humanize id: 1234567, min_length: 20
# Returns '222222222222226RDFD'
```

Note that the original length is not preserved during the base conversion, so you will need to explicitly pass in a min_length if you'd like a output id of the same length.

Also note that if you specify a min_length shorter than the actual output id length, the output id will not be modified (as expected).

#### Adding a prefix

Pass in a prefix if you'd like to add a prefix to your humanized id

```ruby
humanized_id = HumanizedId.humanize id: 1234567, min_length: 20, prefix: 'TEST'
# Will return 'TEST222222222222226RDFD'
```

The prefix is added to the humanized id after all other processing (including min_length padding). Therefore the total length of the above example wil be 20 + 4 (length of 'TEST').

### Generating a random humanized id

Call 'generate_random' with optional length and prefix.

```ruby
random_humanized_id = HumanizedId.generate_random
```

Will generate a random human friendly id of default length (see HumanizedId::DEFAULT_GENERATION_LENGTH)

```ruby
random_humanized_id = HumanizedId.generate_random length: 20, prefix: 'TEST'
```

This will generate a random humanized id of length 20 and then add the prefix to the id thus resulting in a total length of 24.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Release

To publish a new version of this gem the following steps must be taken.

- Update the version in the following files
  ```
    CHANGELOG.md
    lib/humanized_id/version.rb
  ```
- Create a tag using the format v0.1.0
- Follow build progress in GitHub actions

## Contributing

1. Fork it ( https://github.com/sealink/humanized_id/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
