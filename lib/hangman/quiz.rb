class Quiz
  attr_reader :guessed

  def initialize(searched_word)
    @solution = searched_word
    @guessed = []

    @letter_slots = "_" * searched_word.length
  end

  def guess!(char)
    char = char.downcase

    found_at = @solution.downcase.split('').enum_for(:each_with_index).select { |c, index|
      c == char
    }.map { |_, index| index }

    found_at.each do |index|
      @letter_slots[index] = @solution[index]
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

