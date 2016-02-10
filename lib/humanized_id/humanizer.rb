# frozen_string_literal: true
require 'facets'

module HumanizedId
  class Humanizer
    DEFAULT_CHARACTERSET = '234679CDFGHJKMNPQRTVWXYZ'.freeze
    RUBY_DIGITMAP = '0123456789abcdefghijklmnopqrstuvwxyz'.freeze

    def initialize(id:, length: nil, prefix: '',
                   source_charset: RUBY_DIGITMAP,
                   target_charset: DEFAULT_CHARACTERSET)
      @id               = id
      @length           = length || id.to_s.length
      @prefix           = prefix
      @source_charset   = source_charset.blank? ? RUBY_DIGITMAP : source_charset
      @target_charset   = target_charset.blank? ? DEFAULT_CHARACTERSET : target_charset
      validate_charset
    end

    def generate_humanized_id
      new_id = id_in_target_charset(id: id_in_target_base(id: @id))
      new_id = resize(id: new_id)
      "#{@prefix}#{new_id}"
    end

    private

    def validate_charset(target_charset: @target_charset, source_charset: @source_charset)
      if target_charset.length > source_charset.length
        fail Error, "Maximum length of allowed characters is #{@source_charset.length}"
      end
    end

    def id_in_target_base(id: @id, target_base: @target_charset.length)
      id.to_s(target_base)
    rescue ArgumentError
      raise Error, "Unable to do base conversion of id: #{id} into base: #{target_base}"
    end

    def id_in_target_charset(
      id: @id,
      source_charset: @source_charset,
      target_charset: @target_charset
    )
      source_charset_subset = source_charset.slice(0, target_charset.length)
      id.tr(source_charset_subset, target_charset)
    end

    def resize(id: @id, required_length: @length, padding_value: @target_charset[0])
      if required_length > id.length
        id = "#{padding_value * (required_length - id.length)}#{id}"
      elsif required_length < id.length
        id = id.slice(0..(required_length - 1))
      end
      id
    end
  end
end
