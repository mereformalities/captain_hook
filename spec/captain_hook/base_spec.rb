require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
describe CaptainHook::Base do
  context "with a valid repo" do
    before(:each) do
      @repo = mock("Git repo").as_null_object
      @hook = CaptainHook::Base.new(@repo)
    end

    describe :handle_post_receive do
      before(:each) do
        @yielded = nil
        @args = "sha1 sha2 refree"
        $stdin.stub!(:read).and_return(@args)
        
        @hook.handle_post_receive do |event|
          @yielded = event
        end
      end
      it "should yield a CaptainHook::PostReceiveEvent" do
        @yielded.should be_an_instance_of(CaptainHook::PostReceiveEvent)
      end
      
      it "should use $stdin to parse args" do
        CaptainHook::PostReceiveEvent.should_receive(:new).
          with({:old_sha => "sha1",
            :new_sha => "sha2",
            :ref_name => "refree"})
        @hook.handle_post_receive
      end
    end
  end
  
end
