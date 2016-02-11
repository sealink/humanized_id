module HumanizedId
  class RandGenerator
    def initialize(prefix: '', length:)
      @prefix = prefix.nil? ? '' : prefix
      @length = length
      @target_charset = HumanizedId::CHARACTERSET
    end

    def generate_random_humanized_id
      "#{@prefix}#{generate_random}"
    end

    private

    def generate_random(length: @length, target_charset: @target_charset)
      SecureRandom.random_bytes(length).unpack('C*').map{ |byte|
        idx = byte % 64
        idx = SecureRandom.random_number(target_charset.size) if
          idx >= target_charset.size
        target_charset[idx]
      }.join
    end
  end
end
