# frozen_string_literal: true
module HumanizedId
  class Humanizer
    SOURCE_CHARSET = %w(0123456789abcdefghijklmnopqrstuvwxyz).freeze

    def initialize(id:, length: nil, prefix: '')
      @id               = id
      @length           = length
      @prefix           = prefix.nil? ? '' : prefix
      @target_charset   = HumanizedId::CHARACTERSET.join('')
      @source_charset   = SOURCE_CHARSET.join('')
    end

    def generate_humanized_id
      new_id = convert_to_target_base id: @id
      new_id = convert_to_target_charset id: new_id
      new_id = resize id: new_id if @length
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

    def resize(id: @id, required_length: @length, target_charset: @target_charset)
      if required_length > id.length
        padding = target_charset[0] * (required_length - id.length)
        id = "#{padding}#{id}"
      end
      id
    end
  end
end
