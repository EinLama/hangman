class Quiz
  attr_reader :guessed

  def initialize(searched_word)
    @solution = searched_word
    @guessed = []

    @letter_slots = "_" * searched_word.length
  end

  def guess!(char)
    found = @solution.downcase.index(char.downcase)
    return false unless found

    if found >= 0
      @letter_slots[found] = @solution[found]
    end

    if guessed.include?(char)
      false
    else
      guessed << char
      true
    end
  end

  def represent
    @letter_slots
  end
end

