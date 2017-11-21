module Opera
  class Parameter
    attr_accessor :name, :type, :in, :format, :schema, :required, :items

    def initialize(options={})
      @name = options.fetch(:name)
      @type = options.fetch(:type)
      @in = options.fetch(:in)
      @format = options.fetch(:format)
      @schema = options.fetch(:schema)
      @required = options.fetch(:required)
      @items = options.fetch(:items)
    end
  end
end
