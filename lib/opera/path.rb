require 'opera/parameter'

module Opera
  class Path
    attr_accessor :method, :path
    attr_accessor :consumes, :produces
    attr_accessor :required_parameters
    attr_accessor :optional_parameters

    def initialize(method:, path:, operation:)
      @method = method.upcase
      @path = path
      @operation = operation
      @consumes = operation['consumes']
      @produces = operation['produces']
      @required_parameters = []
      @optional_parameters = []
      @operation['parameters'].each do |parameter|
        if parameter['required']
          required_parameters << Parameter.new(parameter)
        else
          optional_parameters << Parameter.new(parameter)
        end
      end
    end

    def validate_request!(env)
      request = Rack::Request.new(env)
      raise Opera::MethodDoesNotMatchError if request.method != method.to_s
      body = request.body if request.body
      query = request.query_string if request.query_string
    end

    class JsonHandler
      def call(body)
        JSON.load(body)
      end
    end

    class FormHandler
      def call(body)

      end
    end
  end
end
