module Opera
  class Definition
    attr_accessor :type, :properties, :required

    def initialize(options={})
      @type = options.fetch(:type, '')
      @properties = options.fetch(:properties, '')
      @required = options.fetch(:required, '')
    end
  end
end
