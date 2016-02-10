module HumanizedId
  class << self
    DEFAULT_GENERATION_LENGTH = 24

    def humanize(id:, length: nil, prefix: '', source_charset: nil, target_charset: nil)
      HumanizedId::Humanizer.new(
        id: id,
        length: length,
        prefix: prefix,
        source_charset: source_charset,
        target_charset: target_charset
      ).generate_humanized_id
    end

    def generate_random(prefix: '', length: default_random_length, real_rand: false,
                        source_charset: nil, target_charset: nil)
      HumanizedId::RandGenerator.new(
        prefix: prefix,
        length: length,
        real_rand: real_rand,
        source_charset: source_charset,
        target_charset: target_charset
      ).generate_random_humanized_id
    end

    def default_random_length
      DEFAULT_GENERATION_LENGTH
    end
  end
  Error = Class.new(StandardError)
end

require 'humanized_id/version'
require 'humanized_id/humanizer'
require 'humanized_id/rand_generator'
