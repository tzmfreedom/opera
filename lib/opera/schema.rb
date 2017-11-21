require 'rack'

module Opera
  class Schema
    attr_accessor :paths, :schemes, :base_path, :definitions

    def find_best_fit_route(env)
      request = Rack::Request.new(env)
      target_paths = @paths[request.method].filter do |regexp, path|
        request.path =~ regexp
      end
      target_paths.max { |(a_regexp, a), (b_regexp, b)| a_regexp.length <=> b_regexp.length }[1]
    end
  end
end
