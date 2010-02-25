module CaptainHook
  class Base
    attr_accessor :repo
    
    def initialize(repo)
      @repo = repo
    end

    def handle_post_receive(data = nil, &block)
      data = data || $stdin
      post_receive = post_receive_from_data(data)
      
      dsl = CaptainHook::DSL::HandlePostReceive.new(post_receive)
      dsl.run(&block) if block_given?
    end
    
    private
    
    def post_receive_from_data(data)
      args = data.read.split(" ")
      post_receive = CaptainHook::PostReceiveEvent.new(
        :old_sha  => args[0],
        :new_sha  => args[1],
        :ref_name => args[2],
        :repo     => @repo
      )
    end
  end  
end