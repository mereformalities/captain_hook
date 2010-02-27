module CaptainHook
  module DSL
    module Base
      def run &block
        instance_eval &block
      end
    end
  end
end