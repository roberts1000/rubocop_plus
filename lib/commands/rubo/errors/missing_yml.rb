module RubocopPlus
  module Commands
    # The rubo command performs some sanity checking to make sure the current application is using a well defined
    # .rubocop.yml.  If the .rubocop.yml file is missing, a MissingYml error is raised.
    class MissingYml < StandardError
      def message
        "\n  The application does not have a .rubocop.yml file.  Run the installer to generate one:\n" \
        "    rubo --init\n\n".rubo_red
      end
    end
  end
end
