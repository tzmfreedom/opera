require 'opera/parameter'
require 'opera/errors'

module Opera
  class Path
    attr_accessor :method, :path, :path_regexp
    attr_accessor :consumes, :produces
    attr_accessor :required_parameters
    attr_accessor :optional_parameters

    def initialize(method:, base_path:, path:, operation:)
      @method = method.to_s.upcase
      @path = path
      @path_regexp = path_to_regexp(base_path, path)
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
      raise Opera::MethodDoesNotMatchError if request.request_method.upcase != method
      raise Opera::PathDoesNotMatchError unless m = request.path.match(path_regexp)
      body = request.body if request.body
      query = request.GET
      form_parameters = retrieve_form_parameters(request)
      headers = retrieve_headers(request)
      errors = []

      # check required_parameter
      required_parameters.each do |parameter|
        if parameter.query? && !query.include?(parameter.name)
          errors << parameter
        elsif parameter.header? && !headers.include?(parameter.name)
          errors << parameter
        elsif parameter.form? && !form_parameters.include?(parameter.name)
          errors << parameter
        elsif parameter.body? && true
          errors << parameter
        end
      end

      # coerce and check data-type
      parameters.each do |parameter|
        if parameter.query? && query.include?(parameter.name)
          parameters if parameter.coerce(query[parameter.name])
        end
      end
      raise_error(errors) unless errors.present?
    end

    def retrieve_headers(request)
      headers = request.env.select { |k, v| k.start_with?('HTTP_') }
      headers.inject({}) do |h, (k, v)|
        downcased_key = k.sub(/^HTTP_/, '').downcase
        header_key = downcased_key.gsub(/(^|_)\w/) { |word|
          word.upcase
        }.gsub('_', '-')
        h[header_key] = v
        h
      end
    end

    def retrieve_form_parameters(request)
      Rack::Utils.parse_query(request.body)
    end

    def path_to_regexp(base_path, path)
      r = path.gsub(/{([^\/]+)}/, '(?<\1>[^\/]+)')
      /^#{base_path}#{r}$/
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
