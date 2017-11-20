require 'rack'

module Opera
  class Schema
    attr_accessor :routes

    def initialize
      @routes = Hash.new { |h, k| h[k] = [] }
    end

    def find_best_fit_route(env)
      request = Rack::Request.new(env)
      target_paths = @routes[request.method].filter do |regexp, route|
        request.path =~ regexp
      end
      target_paths.max { |(a_regexp, a), (b_regexp, b)| a_regexp.length <=> b_regexp.length }[1]
    end
  end
end
