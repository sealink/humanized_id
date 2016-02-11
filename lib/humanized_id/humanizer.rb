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
      commands = %i(convert_to_target_base convert_to_target_charset resize)
      new_id = commands.inject(@id) { |previous_id, command| method(command).call(id: previous_id) }
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
