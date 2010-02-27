require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe CaptainHook::DSL::HandlePostCommit do
  before(:each) do
    @event = mock('post_commit_event',
      :message  => "wave a white flag",
      :author   => "costello",
      :ref_name => "put away the pistol",
      :diff     => "none"
    )
  end

  subject{ CaptainHook::DSL::HandlePostCommit.new(@event)}

  it "should return the event's commit message for #message" do
    subject.message.should == "wave a white flag"
  end
  
  it "should return the event's author for #author" do
    subject.author.should == "costello"
  end
  
  it "should return the event's ref_name for #ref_name" do
    subject.ref_name.should == "put away the pistol"
  end
  
  it "should return the event's diff for #diff" do
    subject.diff.should == "none"
  end
  
  it "should let a block run against itself like a good DSL" do
    subject.run do
      "#{author} - #{ref_name}"
    end.should == "costello - put away the pistol"
    
  end
end
