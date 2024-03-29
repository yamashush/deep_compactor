# frozen_string_literal: true

require_relative "deep_compactor/version"

# For deep compact nested Array and Hash.
module DeepCompactor
  refine Array do
    # @return [Array]
    # @see https://docs.ruby-lang.org/en/master/Array.html#method-i-compact
    def deep_compact
      map do |value|
        if value.is_a?(Array) || value.is_a?(Hash)
          value.deep_compact
        else
          value
        end
      end.compact
    end

    # @return [self, nil]
    # @see https://docs.ruby-lang.org/en/master/Array.html#method-i-compact-21
    def deep_compact!
      compacted = deep_compact

      if self == compacted
        nil
      else
        replace(compacted)
      end
    end

    # @return [Array]
    def deep_compact_blank
      map do |value|
        if value.is_a?(Array) || value.is_a?(Hash)
          value.empty? ? nil : value.deep_compact_blank
        else
          value
        end
      end.compact
    end

    # @return [self, nil]
    def deep_compact_blank!
      compacted = deep_compact_blank

      if self == compacted
        nil
      else
        replace(compacted)
      end
    end
  end

  refine Hash do
    # @return [Hash]
    # @see https://docs.ruby-lang.org/en/master/Hash.html#method-i-compact
    def deep_compact
      transform_values do |value|
        if value.is_a?(Array) || value.is_a?(Hash)
          value.deep_compact
        else
          value
        end
      end.compact
    end

    # @return [self, nil]
    # @see https://docs.ruby-lang.org/en/master/Hash.html#method-i-compact-21
    def deep_compact!
      compacted = deep_compact

      if self == compacted
        nil
      else
        replace(compacted)
      end
    end

    # @return [Hash]
    def deep_compact_blank
      transform_values do |value|
        if value.is_a?(Array) || value.is_a?(Hash)
          value.empty? ? nil : value.deep_compact_blank
        else
          value
        end
      end.compact
    end

    # @return [self, nil]
    def deep_compact_blank!
      compacted = deep_compact_blank

      if self == compacted
        nil
      else
        replace(compacted)
      end
    end
  end
end
