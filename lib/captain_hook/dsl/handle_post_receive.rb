module CaptainHook
  module DSL
    class HandlePostReceive
      include Base
      
      def initialize(post_receive_event)
        @post_receive_event = post_receive_event
      end

      def message
        @post_receive_event.message
      end
      
      def ref_name
        @post_receive_event.ref_name
      end
      
      def author
        @post_receive_event.author
      end      
    end
  end
end