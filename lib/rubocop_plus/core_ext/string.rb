# Add some ome simple colorization methods for formatting console output.
# Prefix methods with rs_ so they don't collide with other gems.
class String
  class << self
    attr_accessor :allow_color
  end

  def rubo_colorize(color_code)
    String.allow_color ? "\e[#{color_code}m#{self}\e[0m" : self
  end

  def rubo_red
    rubo_colorize(31)
  end

  def rubo_green
    rubo_colorize(32)
  end

  def rubo_yellow
    rubo_colorize(33)
  end
end
