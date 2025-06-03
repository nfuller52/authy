# frozen_string_literal: true

module Renderers
  class Json < BaseRenderer
    TRANSFORMERS = [
      Renderers::Json::Transformers::CamelizeKeys,
      Renderers::Json::Transformers::Boolean
    ].freeze
  end
end
