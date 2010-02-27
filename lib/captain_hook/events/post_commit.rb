module CaptainHook
  module Events
    class PostCommit
      def initialize(options={})
        @repo = options[:repo]
      end
      
      # The represents the git commit object in question
      def commit
        @commit ||= @repo.commit(@repo.head.commit)
      end
      
      # The commit message
      def message
        commit.message
      end
      
      def author
        commit.author
      end
      
      def ref_name
        @ref_name ||= @repo.head.name
      end
    
    end
  end
end