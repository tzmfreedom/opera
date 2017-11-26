require 'spec_helper'
require 'pry'
require 'pry-byebug'

RSpec.describe ::Opera::Schema do
  let!(:schema) {
    schema = described_class.new
    schema.paths = {
      'GET' => [
        [
          /hogehoge/,
          ::Opera::Path.new(method: 'GET', path: '/hogehoge', operation: { parameters: []})
        ],
      ]
    }
    schema
  }
  it do
    env = { 'REQUEST_METHOD'=> 'GET', 'PATH_INFO' => '/api/hogehoge' }
    res = schema.find_best_fit_route(env)
  end
end