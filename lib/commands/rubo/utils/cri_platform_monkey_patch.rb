module Cri
  # A small monkey patch to force the cri gem to stop coloring output.
  module Platform
    def self.color?(_io)
      false
    end
  end
end
