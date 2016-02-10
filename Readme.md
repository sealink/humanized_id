# HumanizedId

HumanizedId is a gem designed to help you either:
 - Convert an existing numerical id into a 'human friendly' id
 - Generate a random 'human friendly' id

A 'humanized' (or 'human friendly') id is an id that is easy to read & copy and does not contain vague or vulgur references.
However, it is important to note that the gem allows you to optionally pass in your own target characterset,
and so it is therefore possible for you to create un-human friendly ids

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

The simplest way to call humanize is to pass in the existing id,
which will generate a new id based on a default characterset.
*Note that the existing id must be a numerical id.*
```ruby
humanized_id = HumanizedId.humanize id: 12312426232
```

You may also pass in an optional length for the humanized_id
```ruby
humanized_id = HumanizedId.humanize id: 12312426232, length: 20
```
By default, the length of the humanized id matches the length of the original id.
Padding is used to fill in any loss in precision during the characterset conversion.
You may specify a length that is shorter than the

