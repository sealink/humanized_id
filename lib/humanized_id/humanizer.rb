# frozen_string_literal: true
module HumanizedId
  class Humanizer
    SOURCE_CHARSET = (('0'..'9').to_a + ('a'..'z').to_a).freeze

    def initialize(id:, min_length: nil, prefix: '')
      @id               = id
      @min_length       = min_length
      @prefix           = prefix.to_s
      @target_charset   = CHARSET.join
      @source_charset   = SOURCE_CHARSET.join
    end

    def generate_humanized_id
      new_id = convert_to_target_base id: @id
      new_id = convert_to_target_charset id: new_id
      new_id = resize id: new_id if @min_length
      "#{@prefix}#{new_id}"
    end

    private

    def convert_to_target_base(id:)
      fail Error, 'id is not an integer' unless id.is_a? Integer
      id.to_s(@target_charset.length)
    end

    def convert_to_target_charset(id:)
      source_charset_subset = @source_charset.slice(0, @target_charset.length)
      id.tr(source_charset_subset, @target_charset)
    end

    def resize(id:)
      return id if @min_length.nil? || @min_length <= id.length
      padding = @target_charset[0] * (@min_length - id.length)
      "#{padding}#{id}"
    end
  end
end
