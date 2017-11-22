require 'opera/schema'
require 'opera/path'
require 'opera/definition'

module Opera
  module Driver
    class OpenApi2
      def initialize(schema)
        @schema = schema
      end

      def call
        schema = Opera::Schema.new
        schema.base_path = @schema['basePath']
        schema.schemes = @schema['schemes']

        paths = Hash.new { |h, k| h[k] = [] }
        @schema['paths'].each do |path, api_spec|
          api_spec.each do |method, operation_spec|
            paths[method.upcase] << [
              path_to_regexp(schema, path),
              Path.new(method: method, path: path, operation: operation_spec)
            ]
          end
        end
        schema.paths = paths

        schema.definitions = @schema['definitions'].inject({}) do |h, (name, schema)|
          h[name] = Definition.new(name: name, schema: schema)
          h
        end unless @schema['definitions'].nil?

        schema
      end

      def path_to_regexp(schema, path)
        regexp = path.gsub(/{([^\/]+)}/, '(?<\1>[^\/]+)')
        /^#{schema.base_path}#{regexp}$/
      end
    end
  end
end
