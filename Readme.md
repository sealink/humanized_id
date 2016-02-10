# HumanizedId

HumanizedId is a gem designed to help you either:
 - Convert an existing alphanumerical id into a 'human friendly' id
 - Generate a random 'human friendly' id at a given or default length

A 'humanized' (or 'human friendly') id is an id that is easy to
read & copy and does not contain vague or vulgur references.

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

The simplest way to call humanize is to pass in an existing alphanumerical id,
and let HumanizedId return a human friendly version of that id

```ruby
humanized_id = HumanizedId.humanize id: 'AW121314WFAAGARS3'
```

This is done by replacing any 'bad' characters in the id with random 'good' character
from the applicable characterset (see HumanizedId::CHARACTERSET). The result is an id
of the equivilant size but some characters changed.

WARNING: Because the 'bad' characters are replaced with random good characters, the humanize
process is unique on each run. Therefore, given a 'bad' id, do not expect to get the same 'good'
id each time you run the humanize process. It is recommended that you store your new humanized id
in persistent storage if you would like to reference it later.

#### Preserving, adding or removing length

An optional flag can be passed in to add, remove or preserve length

```ruby
humanized_id = HumanizedId.humanize id: 'AW121314WFAAGARS3', length: 20
```

By default, the humanized id will be the same length as the original id.
If you specify a length greater than the original id,
then the id will be prefixed with random characters to meet the required length.
If you pass in a shorter length than the original id, then the humanized id
will be sliced to meet the required length

#### Adding a prefix

Pass in a prefix if you'd like to add a prefix to your humanized id

```ruby
humanized_id = HumanizedId.humanize id: 'AW121314WFAAGARS3', length: 20, prefix: 'TEST'
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
