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
