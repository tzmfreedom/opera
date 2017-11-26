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

    def query?
      @in == 'query'
    end

    def body?
      @in == 'body'
    end

    def header?
      @in == 'header'
    end

    def form?
      @in == 'form'
    end

    def coerce(value)
      camelized_type_name = type.gsub(/^\w/) { |w| w.upcase }
      coercer = Opera::Parameter.const_get("#{camelized_type_name}Coercer", false)
      coercer.call(value)
    end

    class StringCoercer
      def call(value)
        value.to_s
      end
    end

    class IntegerCoercer
      def call(value)
        value.to_i
      end
    end

    class BooleanCoercer
      def call(value)
        bool_string = value.to_i
        return true if bool_string =~ /^(true|t|1)$/
        return false if bool_string =~ /^(false|f|0)$/
      end
    end

    class ObjectCoercer
      def call(value)

      end
    end
  end
end
