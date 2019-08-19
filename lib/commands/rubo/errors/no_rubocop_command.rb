module RubocopPlus
  module Commands
    # The rubo command will check to make sure the `rubocop` command exists.  When users install rubocop_plus, rubocop_plus
    # will automatically install a version of rubocop.  Users may delete rubocop at a later time.  If rubocop isn't available
    # on the system, NoRubocopCommand will be raised.
    class NoRubocopCommand < StandardError
      def message
        "\n" \
        "  The 'rubocop' command is not available.  Is the rubocop gem installed?  Verify by executing\n" \
        "  'gem list rubocop'.  If rubocop is not listed, reinstall rubocop_plus.\n\n".rubo_red
      end
    end
  end
end
