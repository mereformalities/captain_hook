require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "CaptainHook" do
  describe "CaptainHook.from_path" do
    before(:each) do
      Grit.stub!(:new)
    end
    it "should create a grit repo based on the path" do
      Grit.should_receive(:new).with('foo')
      c = CaptainHook.from_path('foo')
    end    
    
    it "should return an instance of CaptainHook" do
      CaptainHook.from_path('foo').should be_an_instance_of(CaptainHook::Base)
    end
  end
  
end
