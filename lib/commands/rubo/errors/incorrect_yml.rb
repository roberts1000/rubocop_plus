module RubocopPlus
  module Commands
    # The rubo command performs some sanity checking to make sure the current application is using a well defined
    # .rubocop.yml.  It problems are found, an IncorrectYml error is raised.
    class IncorrectYml < StandardError
      def message
        "\n" \
        "  The .rubocop.yml file does not appear to have the correct configuration to read from the\n" \
        "  rubocop_plus gem.  To correct the problem:\n" \
        "    1. Rename your existing .rubocop.yml to .rubocop.yml.bak\n" \
        "    2. Run the installer to generate a fresh .rubocop.yml\n" \
        "       rubo --init\n\n".rubo_red
      end
    end
  end
end
