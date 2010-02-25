require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CaptainHook::PostReceiveEvent do
  before(:each) do
    @repo = mock('repo')
    @ref_name = 'refs/heads/master'
    @old_commit = mock('commit').as_null_object
    @new_commit = mock('commit').as_null_object
    @repo.stub!(:commit).with('oldsha').and_return(@old_commit)
    @repo.stub!(:commit).with('newsha').and_return(@new_commit)    
  end
  
  subject { 
    CaptainHook::PostReceiveEvent.new(
      :old_sha => "oldsha",
      :new_sha => "newsha",
      :ref_name => @ref_name,
      :repo => @repo
    )
  }
  
  it "should expose new_commit" do
    subject.new_commit.should == @new_commit
  end
  
  it "should expose old_commit" do
    subject.old_commit.should == @old_commit
  end
  
  describe "#ref_name" do
    it "should parse from refs/heads/etc" do
      subject.ref_name.should == "master"
    end
    
    it "should return 'unknown' if it can't be parsed" do
      @ref_name = "bogus"
      subject.ref_name.should == "unknown"
    end
    
  end
  
  context "#commits" do
    it "should expose commits between old and new" do
      @repo.stub!(:commits_between).and_return(%w{id ego})
      subject.commits.should == %w{id ego}
    end

    it "should cache the list of commits" do
      @repo.should_receive(:commits_between).
        once().
        and_return(true)
      2.times { subject.commits }
    end
    
    it "should get the commits from old -> new" do
      @repo.should_receive(:commits_between).with(@new_commit, @old_commit)
      subject.commits
    end
  end
end