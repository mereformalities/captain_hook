module CaptainHook
  module DSL
    class HandlePostCommit
      include Base
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
      
        
    end
  end
end
