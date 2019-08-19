require "rubocop_plus"

require_relative "rubo/utils/which"
require_relative "rubo/helpers/misc"
require_relative "rubo/helpers/output"
require_relative "rubo/helpers/validations"

require_relative "rubo/errors/missing_yml"
require_relative "rubo/errors/incorrect_yml"
require_relative "rubo/errors/no_rubocop_command"
require_relative "rubo/errors/bad_output"
require_relative "rubo/errors/output_missing"

module RubocopPlus
  module Commands
    # The main class for the rubo command.  When rubo is invoked on the command line, this class is initiated and the 'run'
    # method is called.
    class Rubo < Cri::CommandRunner
      def run
        prepare_options
        validate_pre_run!
        write_starting_message
        delete_rubocop_folder
        invoke_rubocop
        generate_total_violations_file
        validate_post_run!
        write_results_message
      end

      # Perform all of the checks to make sure rubo can actually run.  This method is called by the 'run' method when
      # 'rubo' is called.  It's also called with 'rubo --validate' is called.
      def validate_pre_run!
        check_if_yml_present!
        check_if_yml_has_correct_content!
        check_if_rubocop_command_exists!
      end

      def validate_post_run!
        check_if_results_exist!
      end

      def initialize_project
        backup_rubocop_yml_if_present
        template_path = File.expand_path('../templates/.rubocop.yml', __dir__)
        FileUtils.cp(template_path, ".rubocop.yml")
        puts ".rubocop.yml created"
      end

      # Execute rubocop with a tailored set of output files.  Rails checks are activated in the default config/rubocop.yml file
      # so we do not explicitly activate them there.
      def invoke_rubocop
        cmd = is_in_gemfile_dot_lock? ? "bundle exec rubocop" : "rubocop"
        # Make sure we always use the specific version of rubocop.  Without this line, the latest version of rubocop
        # will be used if a user installs a version that is newer than what we want to use.
        cmd += " _#{RubocopPlus::RUBOCOP_VERSION}_"
        cmd += " --format simple --out #{style_issues_text_file_name}"
        cmd += " --format html --out #{style_issues_html_file_name}"
        cmd += " --format offenses --out #{style_counts_text_file_name}"
        cmd += checkstyle_options
        system cmd
      end

      # Generates the XML reports necessary to use the Checkstyle Plugin on Jenkins.  It is only needed for the CI so return an
      # empty string unless the --checkstyle option is present.
      def checkstyle_options
        return "" unless options[:checkstyle]

        cmd = " --require rubocop/formatter/checkstyle_formatter"
        cmd += " --format RuboCop::Formatter::CheckstyleFormatter"
        cmd + " --out #{output_folder_name}/checkstyle.xml"
      end

      # While using SublimeText with the SFTP plugin, we noticed the SFTP plugin would not automatically download newer versions
      # of the generated rubocop files at times.  Rubocop should overwrite the files, but we goahead and explicity delete the
      # folder in the hopes that will help resolve the file syncing issues for editors (we're not 100% sure this helps).
      def delete_rubocop_folder
        FileUtils.remove_dir(output_folder_name, true)
      end

      private

      def backup_rubocop_yml_if_present
        return unless File.file?(".rubocop.yml")

        FileUtils.mv(".rubocop.yml", ".rubocop.yml.bak")
        puts ".rubocop.yml renamed to .rubocop.yml.bak"
      end

      # The cri doesn't do a good job of preparing the options.  Instead of having symbols like :"no-color", :no_color is better.
      def prepare_options
        normalize_options
        String.allow_color = !options[:no_color]
      end

      def normalize_options
        no_color = options.delete(:"no-color")
        options[:no_color] = no_color.nil? ? false : no_color
        options[:checkstyle] = false unless options.has_key?(:checkstyle)
      end
    end
  end
end
