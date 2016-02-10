module HumanizedId

  DEFAULT_GENERATION_LENGTH = 24
  CHARACTERSET =
    (('0'..'9').to_a + ('A'..'Z').to_a - %w(0 1 5 8 A B E I L O S U)).join('').freeze

  class << self

    def humanize(id:, length: nil, prefix: '')
      HumanizedId::Humanizer.new(id: id, length: length, prefix: prefix).generate_humanized_id
    end

    def generate_random(prefix: '', length: DEFAULT_GENERATION_LENGTH, real_rand: false)
      HumanizedId::RandGenerator.new(
        prefix: prefix, length: length, real_rand: real_rand
      ).generate_random_humanized_id
    end

  end
  Error = Class.new(StandardError)
end

require 'humanized_id/version'
require 'humanized_id/humanizer'
require 'humanized_id/rand_generator'
