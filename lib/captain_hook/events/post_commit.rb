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
      
      def sha
        commit.sha
      end
      
      # The diff string from the commit
      # Concatenates all of the sub-diffs into one string
      def diff
        @diff ||= begin
          commit.diffs.collect{|diff| diff.diff}.join("\n")
        end
      end
      
      def ref_name
        @ref_name ||= @repo.head.name
      end
    
    end
  end
end