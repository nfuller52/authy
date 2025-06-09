# frozen_string_literal: true

require 'zeitwerk'

# feels hacky?
module Formatters; end
module Middleware; end
module Renderers; end
module Support; end

loader = Zeitwerk::Loader.new

paths = {
  'data' => nil,
  'formatters' => Formatters,
  'middleware' => Middleware,
  'modules' => nil,
  'renderers' => Renderers,
  'support' => Support
}

paths.each do |dir, namespace|
  path = File.expand_path("../../src/#{dir}", __dir__)

  if namespace
    loader.push_dir(path, namespace: namespace)
  else
    loader.push_dir(path)
  end
end

loader.inflector.inflect(
  'http' => 'HTTP',
  'oauth' => 'OAuth'
)

loader.enable_reloading if ENV['ENVIRONMENT'] == 'local'
loader.setup
