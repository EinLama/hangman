require "spec_helper"

RSpec.describe Quiz do
  context "winning" do
    it "is not solved on start" do
      expect(Quiz.new("hello")).to_not be_solved
    end

    it "is not solved after some guesses" do
      q = Quiz.new("abc")
      expect(q).to_not be_solved
      q.guess! "d"; q.guess! "a"
      q.guess! "b"; q.guess! "b"

      expect(q).to_not be_solved
    end

    it "is solved once all letters are guessed" do
      q = Quiz.new("abc")
      expect(q).to_not be_solved
      q.guess! "d"; q.guess! "a"
      q.guess! "b"; q.guess! "c"

      expect(q).to be_solved
    end
  end

  context "diagram" do
    let(:diagram) { double }
    let(:quiz) { Quiz.new "abc", diagram }

    it "adds a stroke to the diagram on wrong guess" do
      expect(diagram).to receive(:next_stroke!)
      quiz.guess! "x"
    end

    it "does not add a stroke to the diagram on correct guess" do
      expect(diagram).to_not receive(:next_stroke!)
      quiz.guess! "a"
    end

    it "does not add a stroke to the diagram on duplicate guess" do
      expect(diagram).to_not receive(:next_stroke!)
      quiz.guess! "a"; quiz.guess! "a"
      quiz.guess! "c"
      quiz.guess! "b"; quiz.guess! "b"
    end
  end

  context "losing" do
    it "is not over when the diagram is incomplete" do
      diagram = double({:complete? => false})

      quiz = Quiz.new "abc", diagram
      expect(quiz).to_not be_game_over
    end

    it "is game over when the diagram is complete" do
      diagram = double({:complete? => true})

      quiz = Quiz.new "abc", diagram
      expect(quiz).to be_game_over
    end
  end

  context "Batman" do
    let(:batman) { Quiz.new "Batman" }

    it "shows a representation of a word" do
      expect(batman.represent).to eq("______")

      dog = Quiz.new "Dog"
      expect(dog.represent).to eq("___")
    end

    it "accepts a letter as guess and returns :correct" do
      expect(batman.guess!("m")).to eq(:correct)
      expect(batman.represent).to eq("___m__")
    end

    it "returns :wrong if a letter isn't hit" do
      expect(batman.guess!("x")).to eq(:wrong)
      expect(batman.guessed).to eq(["x"])
    end

    it "accepts letter insensitive of case" do
      expect(batman.guess!("b")).to eq(:correct)
      expect(batman.represent).to eq("B_____")

      expect(batman.guess!("T")).to eq(:correct)
      expect(batman.represent).to eq("B_t___")
    end

    it "adds a letter to the guessed list once guessed" do
      batman.guess! "m"
      expect(batman.guessed).to eq(["m"])

      batman.guess! "t"
      expect(batman.guessed).to eq(["m", "t"])
    end

    it "doesn't add a letter twice and spots duplicates" do
      batman.guess! "m"

      expect(batman.guess!("m")).to eq(:illegal)
      expect(batman.guessed).to eq(["m"])
    end

    it "returns :illegal if a letter is guessed twice and doesn't add it again even if case differs" do
      batman.guess! "m"

      expect(batman.guess!("M")).to eq(:illegal)
      expect(batman.guessed).to eq(["m"])
    end

    context "multiple letters hit" do
      it "reveals all occurrences of a letter" do
        expect(batman.guess!("a")).to eq(:correct)
        expect(batman.represent).to eq("_a__a_")
      end

      it "still does not add the char more than once to the guessed list" do
        expect(batman.guess!("a")).to eq(:correct)
        expect(batman.guessed).to eq(["a"])
      end
    end

    context "illegal input" do
      it "should take the first character if more than one is entered" do
        expect(batman.guess!("abcdef")).to eq(:correct)
        expect(batman.guessed).to eq(["a"])
      end

      it "returns false if input is too short" do
        expect(batman.guess!("")).to eq(:illegal)
        expect(batman.guess!(nil)).to eq(:illegal)
      end
    end

  end
end
