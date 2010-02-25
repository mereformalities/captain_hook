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
        
  end
end