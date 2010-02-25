module CaptainHook
  module DSL
    class HandlePostReceive
      def initialize(post_receive_event)
        @post_receive_event = post_receive_event
      end

      def message
        puts "post-receive: #{@post_receive_event.message}"
        @post_receive_event.message
      end
      
      def ref_name
        @post_receive_event.ref_name
      end
      
      def author
        @post_receive_event.author
      end
      
      def run &block
        instance_eval &block
      end
    end
  end
end