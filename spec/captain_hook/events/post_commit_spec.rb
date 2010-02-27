require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe CaptainHook::Events::PostCommit do
  before(:each) do
    @diff = mock('diff', :diff => "foo")
    @repo = mock('repo', 
      :head   => mock('head', :commit => 'sha1', :name => "talking"),
      :commit => mock('commit', 
        :message => 'been a long time',
        :author  => 'a visionary',
        :diffs   => [@diff, @diff, @diff])
    )
  end
  
  subject { CaptainHook::Events::PostCommit.new(:repo => @repo) }
  
  it "should expose the latest commit" do
    subject.commit.message.should be
  end
  
  it "should expose the message of the latest commit" do
    subject.message.should == "been a long time"
  end
  
  it "should expose the author of the latest commit" do
    subject.author.should == 'a visionary'
  end
  
  it "should expose the ref-name of the latest commit" do
    subject.ref_name.should == "talking"
  end
  
  describe "#diff" do
    it "should concatenate the diffs from the latest commit" do
      expected_diff = "#{@diff.diff}\n#{@diff.diff}\n#{@diff.diff}"
      subject.diff.should == expected_diff
    end
  end
end