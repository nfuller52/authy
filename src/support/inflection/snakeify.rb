# frozen_string_literal: true

module Support
  module Snakeify
    UPPER_TO_LOWER_REGEX = /([A-Z]+)([A-Z][a-z])/
    LOWER_TO_UPPER_REGEX = /([a-z\d])([A-Z])/

    def self.snakeify(value)
      raise ArgumentError, 'Can only snakeify String or Symbol' unless value.is_a?(String) || value.is_a?(Symbol)

      return snakeify(value.to_s).to_sym if value.is_a?(Symbol)

      value
        .gsub(UPPER_TO_LOWER_REGEX, '\1_\2')
        .gsub(LOWER_TO_UPPER_REGEX, '\1_\2')
        .tr('-', '_')
        .downcase
    end

    def self.snakeify!(value)
      raise ArgumentError, 'Can only snakeify! String' unless value.is_a?(String)
      raise ArgumentError, 'Can not snakeify! a frozen String' if value.frozen?

      value
        .gsub!(UPPER_TO_LOWER_REGEX, '\1_\2')
        .gsub!(LOWER_TO_UPPER_REGEX, '\1_\2')
        .tr!('-', '_')
        .downcase!
    end

    def self.snakeify_keys(obj, deep: true)
      if obj.is_a?(Array)
        deep ? obj.map { |ele| snakeify_keys(ele) } : obj
      elsif obj.is_a?(Hash)
        obj.each_with_object({}) do |(key, value), result|
          snake_key = snakeify(key)
          new_val = deep ? snakeify_keys(value) : value
          result[snake_key] = new_val
        end
      else
        obj
      end
    end

    def self.snakeify_keys!(obj, deep: true)
      if obj.is_a?(Array)
        deep ? obj.map! { |ele| snakeify_keys!(ele) } : obj
      elsif obj.is_a?(Hash)
        split = obj.to_a
        obj.clear

        split.each do |key, value|
          new_key = snakeify(key)
          new_value = deep ? snakeify_keys!(value, deep: true) : value
          obj[new_key] = new_value
        end

        obj
      else
        obj
      end
    end
  end
end
