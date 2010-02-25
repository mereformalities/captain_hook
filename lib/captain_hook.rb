require 'rubygems'
require 'grit'
module CaptainHook
  require 'captain_hook/base'
  require 'captain_hook/post_receive_event'
  require 'captain_hook/dsl'
  
  def self.from_path(path)
    repo = Grit::Repo.new(path)
    Base.new(repo)
  end
end