require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe CaptainHook::DSL::HandlePostReceive do
  before(:each) do
    @event = mock('post_receive_event',
      :message => "hey hey, mama",
      :author => "zeppelin",
      :ref_name => "misty mountain hop"
    )
  end

  subject{ CaptainHook::DSL::HandlePostReceive.new(@event)}

  it "should return the event's commit message for #message" do
    subject.message.should == "hey hey, mama"
  end
  
  it "should return the event's author for #author" do
    subject.author.should == "zeppelin"
  end
  
  it "should return the event's ref_name for #ref_name" do
    subject.ref_name.should == "misty mountain hop"
  end
  
  it "should let a block run against itself like a good DSL" do
    subject.run do
      "#{author} - #{ref_name}"
    end.should == "zeppelin - misty mountain hop"
  end
end
