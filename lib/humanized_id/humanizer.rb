module HumanizedId
  class Humanizer
    def initialize(id:, total_length: nil, prefix: '', source_charset:, target_charset:)
      @id               = id
      @total_length     = total_length || id.to_s.length
      @prefix           = prefix
      @source_charset   = source_charset
      @target_charset   = target_charset
      validate_charset
    end

    def generate_humanized_id
      new_id = id_in_target_charset(id: id_in_target_base(id: @id))
      new_id = add_padding(id: new_id)
      "#{prefix}#{new_id}"
    end

    private

    def validate_charset
      if @target_charset.length > @source_charset.length
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

    def add_padding(id: @id, total_length: @total_length)
      if total_length > id.length
        padding = target_charset[0] * (total_length - id.length)
        id = "#{padding}#{id}"
      end
      id
    end
  end
end
