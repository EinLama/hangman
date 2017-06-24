
class Diagram
  attr_reader :strokes

  MAX_STROKES = 6

  def initialize
    @strokes = 0
  end

  def empty!
    @strokes = 0
    @state = :empty
    self
  end

  def dead!
    @strokes = MAX_STROKES
    self
  end

  def next_stroke!
    @strokes += 1 unless self.complete?
    self
  end

  def complete?
    @strokes >= MAX_STROKES
  end

  def for_strokes
    draw_lines = []

    dead_lines = self.dead_man.split("\n")
    empty_lines = self.empty_gallow.split("\n")

    empty_lines.each_with_index do |line, index|
      if @strokes >= index
        draw_lines << dead_lines[index]
      else
        draw_lines << empty_lines[index]
      end
    end

    draw_lines
  end

  def to_s
    self.for_strokes.join("\n").rstrip
  end

  def empty_gallow
    s = <<-EOF
      ______
      |/
      |
      |
      |
      |
      --------
    EOF

    s.strip
  end

  def dead_man
    s = <<-EOF
      ______
      |/   |
      |    o
      |   /|\
      |   / \
      |
      --------
    EOF

    s.strip
  end
end
