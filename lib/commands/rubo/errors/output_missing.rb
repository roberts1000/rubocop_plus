module RubocopPlus
  module Commands
    # The rubo command will generate some custom output files.  If those files don't get created properly, rubo will raise
    # OutputMissing.
    class OutputMissing < StandardError
      def initialize(msg="")
        @message = msg
        super
      end

      def message
        @message.rubo_red
      end
    end
  end
end
