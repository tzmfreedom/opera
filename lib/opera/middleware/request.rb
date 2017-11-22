require 'opera/driver/open_api_2'
require 'opera/handler/request'

module Opera
  module Middleware
    class Request
      def initialize(app, options={})
        @app = app
        @options = options
        schema = options.fetch(:schema)
        @schema = Opera::Driver::OpenApi2.new(schema).call
        @handler = Opera::Handler::Request.new(@schema)
      end

      def call(env)
        @handler.call(env)
        @app.call(env)
      end
    end
  end
end
