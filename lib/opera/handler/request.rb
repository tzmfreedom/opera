module Opera
  module Handler
    class Request
      def initialize(schema)
        @schema = schema
      end

      def call(env)
        route = schema.find_best_fit_route(env)
        route.validate_request!(env)
      end
    end
  end
end
