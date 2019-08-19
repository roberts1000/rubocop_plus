module RubocopPlus
  module Commands
    # Helpers for performing validations are grouped in this file.
    class Rubo < Cri::CommandRunner
      def check_if_yml_present!
        raise RubocopPlus::Commands::MissingYml unless rubocop_yml_present?
      end

      def check_if_yml_has_correct_content!
        raise RubocopPlus::Commands::IncorrectYml unless rubocop_yml_has_correct_content?
      end

      def check_if_rubocop_command_exists!
        raise RubocopPlus::Commands::NoRubocopCommand unless rubocop_command_exists?
      end

      def check_if_results_exist!
        error = RubocopPlus::Commands::BadOutput

        check_if_violations_count_exists?
        raise error, "The '#{output_folder_name}' folder does not exist." unless File.directory?(output_folder_name)
        raise error, "Missing #{style_issues_text_file_name}" unless File.exist?(style_issues_text_file_name)
        raise error, "Missing #{style_issues_html_file_name}" unless File.exist?(style_issues_html_file_name)
        raise error, "Missing #{style_counts_text_file_name}" unless File.exist?(style_counts_text_file_name)
      end

      def check_if_violations_count_exists?
        error = RubocopPlus::Commands::BadOutput
        raise error, "Missing #{total_violations_count_text_file_name}" unless File.exist?(total_violations_count_text_file_name)

        violations = File.read(total_violations_count_text_file_name)
        raise error, "#{total_violations_count_text_file_name} is empty" if violations.nil? || violations.strip.empty?
      end

      # This method is called when the user runs `rubo --total-violations`.  That option is used to open the "total violations
      # counts" file  and print the number.  However, the user can run `rubo`, wait for a bit, delete his rubocop folder
      # and THEN run `rubo --total-violations`.  This is a little different from the other checks where we are IMMEDIATELY
      # checking the results of the rubo command.  In those checks, we're trying to make sure the rubo command worked correctly
      # and was successfully able to write results.  In this check, we're making sure the files are still around before we try
      # and open them.
      def check_if_total_violations_count_still_present_and_valid!
        error = RubocopPlus::Commands::OutputMissing
        prefix = "Cannot proceed."
        raise error, "#{prefix}  The '#{output_folder_name}' folder does not exist." unless File.directory?(output_folder_name)

        file_name = total_violations_count_text_file_name
        raise error, "#{prefix}  The #{file_name} file is missing." unless File.exist?(file_name)

        violations = File.read(file_name)
        raise error, "#{prefix}  The #{file_name} file is empty." if violations.nil? || violations.strip.empty?

        violations = violations.strip
        raise error, "#{prefix}  The #{file_name} file contains non-digit characters." unless violations =~ /^\d*$/
      end
    end
  end
end
