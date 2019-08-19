module RubocopPlus
  module Commands
    # Helpers for creating output are grouped in this file.
    class Rubo < Cri::CommandRunner
      def write_results_message
        prefix = "#{total_violations_count} issues found, results written to rubocop/"
        prefix = total_violations_count.zero? ? prefix.rubo_green : prefix.rubo_red
        puts "#{prefix} (rubocop_plus v#{installed_version_of_gem} / rubocop v#{rubocop_version_name})"
      end

      def write_starting_message
        print "Running rubocop ... "
      end

      # Read the total number of violations from the output.  Unfortunately, rubocop doesn't have a direct way to generate
      # this number, but it does produce a file with the output burried inside it.  We can search the file and figure out the
      # violations count.  The file will have a line that looks like this:
      #    1234  Total
      def determine_total_violations_count
        total_line = ""
        File.readlines(style_counts_text_file_name).each { |line| total_line = line if line.include?("Total") }
        @total_violations = total_line.empty? ? 0 : total_line.split(" ").first.to_i
      end

      # Return the total violations count from the last rubocop run and remember the result.  This result should not do
      # any validation to make sure the file exists, or is correct.  That is checked in other parts of the system.
      def total_violations_count
        return @total_violations unless @total_violations.nil?

        first_line = File.read(total_violations_count_text_file_name)
        @total_violations = first_line.strip.to_i
      end

      # This method writes a single integer to a file which represents the total number of violations.  The value in this file
      # can be used to fail builds on the CI/CD pipeline which have too many violations.  Rubocop doesn't appear to have a
      # formatter that will write the total number of violations to a file.  Fortunately, we can pull this information out of
      # some other files and write the output ourselves.
      def generate_total_violations_file
        File.open(total_violations_count_text_file_name, 'w') { |f| f.print determine_total_violations_count }
      end
    end
  end
end
