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
    
    def handle_post_commit(&block)
      post_commit = CaptainHook::Events::PostCommit.new(:repo => self.repo)
      if block_given?
        CaptainHook::DSL::HandlePostCommit.new(post_commit).run(&block)
      end
    end
    
    private
    
    def post_receive_from_data(data)
      args = data.read.split(" ")
      post_receive = CaptainHook::Events::PostReceive.new(
        :old_sha  => args[0],
        :new_sha  => args[1],
        :ref_name => args[2],
        :repo     => @repo
      )
    end
  end  
end