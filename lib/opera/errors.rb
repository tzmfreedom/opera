module Opera
  class MethodDoesNotMatchError < StandardError; end

  class PathDoesNotMatchError < StandardError; end

  class RequiredParameterMissingError < StandardError; end

  class InvalidTypeError < StandardError; end

  class RoutingError < StandardError; end
end