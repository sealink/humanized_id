# frozen_string_literal: true
module HumanizedId
  class Humanizer
    SOURCE_CHARSET = (('0'..'9').to_a + ('a'..'z').to_a).freeze

    def initialize(id:, min_length: nil, prefix: '')
      @id               = id
      @min_length       = min_length
      @prefix           = prefix.nil? ? '' : prefix
      @target_charset   = HumanizedId::CHARACTERSET.join('')
      @source_charset   = SOURCE_CHARSET.join('')
    end

    def generate_humanized_id
      new_id = convert_to_target_base id: @id
      new_id = convert_to_target_charset id: new_id
      new_id = resize id: new_id if @min_length
      "#{@prefix}#{new_id}"
    end

    private

    def convert_to_target_base(id: @id, target_base: @target_charset.length)
      id.to_s(target_base)
    rescue ArgumentError
      raise Error, 'id is not an integer'
    end

    def convert_to_target_charset(
      id: @id, target_charset: @target_charset, source_charset: @source_charset)
      source_charset_subset = source_charset.slice(0, target_charset.length)
      id.tr(source_charset_subset, target_charset)
    end

    def resize(id: @id, min_length: @min_length, target_charset: @target_charset)
      if min_length > id.length
        padding = target_charset[0] * (min_length - id.length)
        id = "#{padding}#{id}"
      end
      id
    end
  end
end
