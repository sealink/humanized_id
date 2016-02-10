require 'random/online'

module HumanizedId
  class RandGenerator
    def initialize(prefix: '', length:, real_rand: false, source_charset: nil, target_charset: nil)
      @prefix = prefix
      @length = length
      @real_rand = real_rand
      @source_charset = source_charset
      @target_charset = target_charset
    end

    def generate_random_humanized_id
      # Generate a random number bigger than we need (to avoid precision loss during humanization).
      # Then request humanization with the original requested length and any prefix
      HumanizedId.humanize(
        id: generate_random_numerical_id(length: @length * 2),
        length: @length,
        prefix: @prefix,
        source_charset: @source_charset,
        target_charset: @target_charset
      )
    end

    private

    def generate_random_numerical_id(length: @length, real_rand: @real_rand)
      # Note that using real_rand has a big performance impact
      if real_rand
        real_rand_generator = RealRand::RandomOrg.new
        return real_rand_generator.randnum(length, 0, 9).join('').to_i
      end
      (Array.new(length) { rand(10) }).join('').to_i
    end
  end
end
