class Banner
  attr_reader :message, :width

  def initialize(message, width = false)
    @message = message
    if width
      if width < message.size || width > (message.size * 2)
        @width = message.size
      else
        @width = width
      end
    end
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    width ? "+-#{"-" * width}-+" : "+-#{"-" * message.size}-+"
  end

  def empty_line
    width ? "| #{' ' * width} |" : "| #{' ' * message.size} |"
  end

  def message_line
    width ? "| #{message.center(width)} |" : "| #{message} |"
  end
end

banner = Banner.new('To boldly go where no one has gone before.', 75)
puts banner
banner = Banner.new('')
puts banner
