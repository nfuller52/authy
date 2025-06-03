# frozen_string_literal: true

module Renderers
  class BaseRenderer
    TRANSFORMERS = [].freeze

    def self.transform(data)
      new.traverse(data)
    end

    def traverse(data)
      case data
      when Hash
        data.each_with_object({}) do |(k, v), acc|
        end
      when Array
        data.map { |node| traverse(node) }
      else
        data
      end
    end

    def transform(acc, key, value)
      TRANSFORMERS.map { |_transformer| call(acc, key, value) }
    end
  end
end
