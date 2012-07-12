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
      
      def diff
        @event.diff
      end
      
      def ref_name
        @event.ref_name
      end
      
      def sha
        @event.sha
      end
        
    end
  end
end
