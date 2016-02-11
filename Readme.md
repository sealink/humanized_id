# HumanizedId

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

The simplest way to call humanize is to pass in an existing numerical id,
and let HumanizedId return a human friendly version of that id. This id will be shorter
in length (due to base conversion) and will be an alphanumerical string based on
a 'human safe' character-set

```ruby
humanized_id = HumanizedId.humanize id: 1234567
# Returns '6RDFD'
```

#### Ensuring minimum length of output id

An optional length flag can be passed in if you'd like to preserve or increase the
length of the returned value. This will be done by 'padding' the return id with the
safe charset default value '2'

```ruby
humanized_id = HumanizedId.humanize id: 1234567, length: 20
# Returns '222222222222226RDFD'
```

Note that the original length is not preserved during the base conversion, so you
will need to explicitely pass in that length if you'd like the output to be of the same
length (using the default padding)

Also note that if you specify a length shorter than the output id, the output id will
not be modified. This is to stop the caller from accidently trimming the output id based
on wrong assumptions. Think of the 'length' argument as a minimum guaranteed length of
the output id

#### Adding a prefix

Pass in a prefix if you'd like to add a prefix to your humanized id

```ruby
humanized_id = HumanizedId.humanize id: 1234567, length: 20, prefix: 'TEST'
# Will return 'TEST222222222222226RDFD'
```

The prefix is added to the humanized id after all other processing (including length padding).
Therefore the total length of the above example wil be 20 + 'TEST'.length = 24

### Generating a random humanized id

Call 'generate_random' with optional length and prefix

```ruby
random_humanized_id = HumanizedId.generate_random
```

Will generate a random human friendly id of default length (see HumanizedId::DEFAULT_GENERATION_LENGTH)

```ruby
random_humanized_id = HumanizedId.generate_random length: 20, prefix: 'TEST'
```

This will generate a random humanized id of length 20 and then add the prefix to the id
thus resulting in a total length of 24

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/sealink/humanized_id/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
