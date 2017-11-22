require 'rack'

module Opera
  class Schema
    attr_accessor :paths, :schemes, :base_path, :definitions

    def find_best_fit_route(env)
      request = Rack::Request.new(env)
      target_paths = @paths[request.request_method.upcase].select do |regexp, path|
        request.path =~ regexp
      end
      best_fit_path = target_paths.max { |(a_regexp, a), (b_regexp, b)|
        a_regexp.length <=> b_regexp.length
      }
      best_fit_path ? best_fit_path[1] : nil
    end
  end
end
