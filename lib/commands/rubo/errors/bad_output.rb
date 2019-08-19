module RubocopPlus
  module Commands
    # When the rubo command runs rubocop, it tells rubocop to output to a specific set of files.  If those files aren't
    # created, (or don't have the expected format), rubo will raise a BadOutput error.
    class BadOutput < StandardError
      def initialize(msg="")
        @details = msg
        super
      end

      def message
        "Error\n\n" \
        "  The output in the rubocop folder does not look correct.  This implies rubo wasn't able to run 'rubocop'\n" \
        "  for some reason: #{@details}.\n\n".rubo_red
      end
    end
  end
end
