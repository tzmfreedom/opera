module Opera
  class Parameter
    attr_accessor :name, :type, :in, :format, :schema, :required, :items

    def initialize(options={})
      @name = options['name']
      @type = options['type']
      @in = options['in']
      @format = options['format']
      @schema = options['schema']
      @required = options.fetch('required', false)
      @items = options['items']
      @ref = options['$ref']
    end
  end
end
