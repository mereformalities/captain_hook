require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CaptainHook::Base do
  context "with a valid repo" do
    before(:each) do
      @repo = mock("Git repo").as_null_object
      @hook = CaptainHook::Base.new(@repo)
    end

    describe :handle_post_receive do
      before(:each) do        
        @args = "sha1 sha2 refree"
        $stdin.stub!(:read).and_return(@args)
      end
      
      it "should call run on a CaptainHook::DSL::HandlePostReceive" do
        dsl = mock()
        CaptainHook::DSL::HandlePostReceive.stub!(:new).and_return(dsl)
        dsl.should_receive(:run)
        @hook.handle_post_receive {}
      end
      
      it "should use $stdin to parse args" do
        CaptainHook::Events::PostReceive.
          should_receive(:new).
          with({
            :old_sha => "sha1",
            :new_sha => "sha2",
            :ref_name => "refree",
            :repo => @repo
          })
            
        @hook.handle_post_receive
      end
    end
    
    describe :handle_post_commit do
      it "should call run on the right DSL handler" do
        dsl = mock()
        CaptainHook::DSL::HandlePostCommit.stub!(:new).and_return(dsl)
        dsl.should_receive(:run)
        @hook.handle_post_commit {}
      end
      
      it "should create a post-commit event with the repo" do
        CaptainHook::Events::PostCommit.should_receive(:new).with({:repo => @repo})
        @hook.handle_post_commit
      end
      
    end
  
    
    
  end
  
end
