require 'opera/driver/open_api_2'

module Opera
  module Middleware
    class Request
      def initialize(app, options={})
        @app = app
        @options = options
        schema = options.fetch(:schema)
        @schema = Opera::Driver::OpenApi2.new(schema).call
      end

      def call(env)

        @app.call(env)
      end
    end
  end
end
