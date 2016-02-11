# frozen_string_literal: true
module HumanizedId
  DEFAULT_GENERATION_LENGTH = 24
  SIMILAR_NUMBERS_LETTERS = %w(0 O 1 I L 5 S 8 B).freeze
  VOWELS = %w(A E I O U).freeze
  CHARACTERSET =
    (('0'..'9').to_a + ('A'..'Z').to_a - SIMILAR_NUMBERS_LETTERS - VOWELS).freeze

  class << self
    def humanize(id:, min_length: nil, prefix: '')
      Humanizer.new(id: id, min_length: min_length, prefix: prefix).generate_humanized_id
    end

    def generate_random(prefix: '', length: DEFAULT_GENERATION_LENGTH)
      RandGenerator.new(prefix: prefix, length: length).generate_random_humanized_id
    end
  end
  Error = Class.new(StandardError)
end

require 'humanized_id/version'
require 'humanized_id/humanizer'
require 'humanized_id/rand_generator'
