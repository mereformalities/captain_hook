module CaptainHook
  class Base
    attr_accessor :repo
    
    def initialize(repo)
      @repo = repo
    end

    def handle_post_receive &block
      args = $stdin.read.split(" ")
      event = CaptainHook::PostReceiveEvent.new(
        :old_sha => args[0],
        :new_sha => args[1],
        :ref_name => args[2]
      ) 
      
      yield event if block_given?
    end

  end  
end