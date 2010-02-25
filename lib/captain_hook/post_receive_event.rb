module CaptainHook
  class PostReceiveEvent
    attr_accessor :repo, :old_commit, :new_commit

    def initialize(options = {})
      @repo       = options[:repo]
      @old_commit = @repo.commit(options[:old_sha])
      @new_commit = @repo.commit(options[:new_sha])
      @full_ref_name   = options[:ref_name]
    end
    
    def commits
      @commits ||= @repo.commits_between(new_commit, old_commit)
    end
    
    def ref_name
      @ref_name ||= begin
        @full_ref_name =~ %r{^refs/(?:tags|heads|remotes)/(.+)} ?
          $1 : "unknown"
      end
    end
    
    # Returns the author of the most-recent revision
    def author
      new_commit.author
    end
    
    # Returns the first line of the most recent revision's commit message
    def message
      @message ||= new_commit.message.split("\n")[0]
    end
    
    # Returns lines 1..n of the most recent revision's commit message
    def message_detail
      @message_detail ||= begin
        new_commit.message.
          split("\n")[1..-1].
          reject{|s| s == ""}.
          join("\n")
        end
    end
        
  end
end