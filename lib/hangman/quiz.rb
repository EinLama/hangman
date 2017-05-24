class Quiz
  def initialize(searched_word)
    @solution = searched_word

    @letter_slots = Array.new(searched_word.length, "_")
  end

  def guess!(char)
    found = @solution.index(char)

    if found >= 0
      @letter_slots[found] = char
    end
  end

  def represent
    @letter_slots.join('')
  end
end
