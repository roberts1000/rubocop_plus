module RubocopPlus
  module Commands
    # Miscellaneous helpers are grouped in this file.
    class Rubo < Cri::CommandRunner
      def rubocop_yml_present?
        File.file?(".rubocop.yml")
      end

      # The Gemfile.lock is auto generated when the 'bundle' command is run.  It doesn't contain superfluous comments or any
      # references to a gem unless the gem is being used.  However, many terms like 'rails' is used in multiple gem name so
      # we need to be smart about checking boundaries.  Each gem line in Gemfile.lock always starts with a couple spaces,
      # followed by the gem name, followed by a single space or newline chracter.
      def is_in_gemfile_dot_lock?
        return false unless File.exist?("Gemfile.lock")

        # Match logic
        #   ^               - match from beginning of string
        #   \s*             - match 0-N white space characters
        #   rubocop_plus    - match the gem_name exactly once
        #   \s              - match one white space character (it will always be a space or a \n)
        File.foreach("Gemfile.lock") { |line| return true if /^\s*rubocop_plus\s/.match?(line) }
        false
      end

      def installed_version_of_gem
        Gem::Version.new(RubocopPlus::VERSION)
      end

      def rubocop_version_name
        Gem::Version.new(RubocopPlus::RUBOCOP_VERSION)
      end

      def output_folder_name
        "rubocop"
      end

      def style_issues_text_file_name
        "#{output_folder_name}/style-issues.txt"
      end

      def style_issues_html_file_name
        "#{output_folder_name}/style-issues.html"
      end

      def style_counts_text_file_name
        "#{output_folder_name}/style-counts.txt"
      end

      def total_violations_count_text_file_name
        "#{output_folder_name}/total-violations-count.txt"
      end

      # Perform some sanity checks to make sure .rubocop.yml has expected content.
      def rubocop_yml_has_correct_content?
        # If we're running from inside the rubocop_plus folder, ignore this check.
        return true if Dir.pwd.include?("rubocop_plus")

        text = File.read(".rubocop.yml")
        text.include?("inherit_gem:") && text.include?("rubocop_plus:")
      end

      def rubocop_command_exists?
        path = Which('rubocop')
        !(path.nil? || path.empty?)
      end
    end
  end
end
