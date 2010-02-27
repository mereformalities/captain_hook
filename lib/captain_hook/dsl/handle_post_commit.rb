module CaptainHook
  module DSL
    class HandlePostCommit
      def initialize(event)
        @event = event
      end
      
      def message
        @event.message
      end
      
      def author
        @event.author
      end
      
      def ref_name
        @event.ref_name
      end
      
      def run &block
        instance_eval &block
      end
        
    end
  end
end
