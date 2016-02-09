# frozen_string_literal: true
module HumanizedId
  class << self
    DEFAULT_CHARACTERSET = '234679CDFGHJKMNPQRTVWXYZ'.freeze
    RUBY_DIGITMAP = '0123456789abcdefghijklmnopqrstuvwxyz'.freeze

    def humanize(
      id:,
      generated_length: nil,
      prefix: '',
      source_charset: RUBY_DIGITMAP,
      target_charset: DEFAULT_CHARACTERSET
    )
      HumanizedId::Humanizer.new(
        id: id,
        generated_length: generated_length,
        prefix: prefix, source_charset: source_charset,
        target_charset: target_charset
      ).generate_humanized_id
    end

    def generate_random(length:)

    end
  end
  Error = Class.new(StandardError)
end

require 'humanized_id/version'
require 'humanized_id/humanizer'
