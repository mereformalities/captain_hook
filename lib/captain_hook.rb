require 'captain_hook/post_receive_event'
require 'captain_hook/base'
module CaptainHook
  def self.from_path(path)
    repo = Grit.new(path)
    Base.new(repo)
  end
end