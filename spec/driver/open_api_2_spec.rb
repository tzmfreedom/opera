require 'spec_helper'
require 'yaml'
require 'pry'
require 'opera/open_class/hash'

RSpec.describe ::Opera::Driver::OpenApi2 do
  let(:sample_yaml) {
    <<~YAML
swagger: "2.0"
host: "petstore.swagger.io"
basePath: "/v2"
schemes:
- "http"
paths:
  /pet:
    post:
      tags:
      - "pet"
      summary: "Add a new pet to the store"
      description: ""
      operationId: "addPet"
      consumes:
      - "application/json"
      - "application/xml"
      produces:
      - "application/xml"
      - "application/json"
      parameters:
      - in: "query"
        name: "foo"
        required: true
      - in: "query"
        name: "bar"
        required: false
      - in: "header"
        name: "foo-h"
        required: true
      - in: "query"
        name: "bar-h"
        required: false
      - in: "path"
        name: "id"
        required: true
      - in: "form"
        name: "foo-f"
        required: true
      - in: "form"
        name: "bar-f"
      responses:
        405:
          description: "Invalid input"
      security:
      - petstore_auth:
        - "write:pets"
        - "read:pets"
  /pet/{id}:
    post:
      tags:
      - "pet"
      summary: "Add a new pet to the store"
      description: ""
      operationId: "addPet"
      consumes:
      - "application/json"
      - "application/xml"
      produces:
      - "application/xml"
      - "application/json"
      parameters:
      - in: "query"
        name: "foo"
        required: true
      - in: "query"
        name: "bar"
        required: false
      - in: "header"
        name: "foo-h"
        required: true
      - in: "query"
        name: "bar-h"
        required: false
      - in: "path"
        name: "id"
        required: true
      - in: "form"
        name: "foo-f"
        required: true
      - in: "form"
        name: "bar-f"
      responses:
        405:
          description: "Invalid input"
      security:
      - petstore_auth:
        - "write:pets"
        - "read:pets"
    YAML
  }
  it do
    schema = YAML.load(sample_yaml)
    driver = described_class.new(schema)
    schema = driver.call
    env = { 'REQUEST_METHOD'=> 'POST', 'PATH_INFO' => '/v2/pet' }
    a = schema.find_best_fit_route(env)
    env = { 'REQUEST_METHOD'=> 'POST', 'PATH_INFO' => '/v2/pet/123' }
    a = schema.find_best_fit_route(env)
  end
end