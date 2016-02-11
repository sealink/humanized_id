require 'facets'

module HumanizedId
  class Humanizer
    def initialize(id:, length: nil, prefix: '')
      @id               = id
      @length           = length || id.to_s.length
      @prefix           = prefix.nil? ? '' : prefix
      @target_charset   = HumanizedId::CHARACTERSET
    end

    def generate_humanized_id
      new_id = translate_id_to_charset
      new_id = resize(id: new_id)
      "#{@prefix}#{new_id}"
    end

    private

    def translate_id_to_charset(id: @id, target_charset: @target_charset)
      new_id = []
      id.to_s.each_char do |char|
        new_id << replace_with_compliant_char(char: char, target_charset: target_charset)
      end
      new_id.join('')
    end

    def replace_with_compliant_char(char:, target_charset: @target_charset)
      return char if target_charset.include? char
      target_charset[SecureRandom.random_number(target_charset.size)]
    end

    def resize(id: @id, required_length: @length)
      if required_length > id.length
        # Pad with random humanized characters
        id = "#{HumanizedId.generate_random(length: (required_length - id.length))}#{id}"
      elsif required_length < id.length
        id = id.slice(0..(required_length - 1))
      end
      id
    end
  end
end
