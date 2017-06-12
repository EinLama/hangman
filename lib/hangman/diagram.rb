
class Diagram
  def initialize
    @strokes = 0
  end

  def empty!
    @strokes = 0
    @state = :empty
    self
  end

  def dead!
    @state = :dead
    self
  end

  def next_step!
    @strokes += 1
    self
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
    if @state == :dead
      self.dead_man
    else
      self.empty_gallow
    end
  end

  def empty_gallow
      <<-EOF
      ______
      |/
      |
      |
      |
      |
      --------
    EOF
  end

  def dead_man
    <<-EOF
      ______
      |/   |
      |    o
      |   /|\
      |   / \
      |
      --------
    EOF
  end
end
