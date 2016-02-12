module HumanizedId
  class RandGenerator
    def initialize(prefix: '', length:)
      @prefix = prefix.nil? ? '' : prefix
      @length = length
      @target_charset = CHARSET
    end

    def generate_random_humanized_id
      "#{@prefix}#{generate_random}"
    end

    private

    def generate_random
      SecureRandom.random_bytes(@length).unpack('C*').map{ |byte| map_to_char(byte) }.join
    end

    def map_to_char(byte)
      index = byte % @target_charset.size
      @target_charset[index]
    end
  end
end
