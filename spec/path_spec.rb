require "spec_helper"
require 'pry'

RSpec.describe Opera::Path do
  let(:params) {
    {
      method: 'GET',
      base_path: '/v2',
      path: '/hogehoge',
      operation: {
        'consumes' => ['application/json'],
        'produces' => ['application/json'],
        'parameters' => [
          {
            'in' => 'query',
            'name' => 'foo',
            'required' => true
          },
          {
            'in' => 'query',
            'name' => 'bar',
            'required' => false
          },
          {
            'in' => 'header',
            'name' => 'Foo-H',
            'required' => true
          },
          {
            'in' => 'header',
            'name' => 'Bar-H',
            'required' => false
          },
          {
            'in' => 'path',
            'name' => 'id',
            'required' => true
          },
          {
            'in' => 'form',
            'name' => 'foo-f',
            'required' => true
          },
          {
            'in' => 'form',
            'name' => 'bar-f',
            'required' => false
          },
        ],
        'responses' => {
          '200' => {

          }
        }
      }
    }
  }

  it "does something useful" do
    env = {
      'REQUEST_METHOD'=> 'GET',
      'PATH_INFO' => '/v2/hogehoge',
      'QUERY_STRING' => 'foo=aaa',
      'HTTP_AUTHORIZATION' => 'aaa',
      'HTTP_CONTENT_TYPE' => 'application/json',
      'HTTP_FOO_H' => 'hoge',
      'rack.input' => 'foo-f=hoge'
    }
    path = described_class.new(params)
    path.validate_request!(env)
  end
end
