class Quiz
  attr_reader :guessed

  def initialize(searched_word)
    @solution = searched_word
    @guessed = []

    @letter_slots = "_" * searched_word.length
  end

  def guess!(char)
    return :illegal if !char || char.length < 1

    char = char[0].downcase

    found_at = @solution.downcase.split('').enum_for(:each_with_index).select { |c, index|
      c == char
    }.map { |_, index| index }

    found_at.each do |index|
      @letter_slots[index] = @solution[index]
    end

    if guessed.include?(char)
      :illegal # duplicate spotted!
    else
      guessed << char

      if found_at.empty?
        :wrong
      else
        :correct
      end
    end
  end

  def represent
    @letter_slots
  end

  def solved?
    !@letter_slots.include?("_")
  end
end

