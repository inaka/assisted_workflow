module AssistedWorkflow::Addons
  
  class Base
    
    def initialize(output, options = {})
      @output = output
      validate_options!(options)
    end
    
    def name
      self.class.name.downcase.split("::").last
    end
    
    def valid?
      false
    end
    
    class << self
      
      def required_options(*args)
        @required_options = Array(args).map(&:to_s)
      end
      
      def get_required_options
        @required_options || []
      end
    end
    
    protected #===============================================================
    
    def log(message)
      @output.say_status(name, message) if @output
    end
    
    def validate_options!(options)
      if options.nil?
        raise AssistedWorkflow::Error, "#{name} missing configuration"
      end
      missing_keys = self.class.get_required_options - options.keys
      if missing_keys.size > 0
        raise AssistedWorkflow::Error, "#{name} missing configuration: #{missing_keys.inspect}"
      end
    end
    
  end
end