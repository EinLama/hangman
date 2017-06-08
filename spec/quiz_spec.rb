require "spec_helper"

RSpec.describe Quiz do
  it "shows a representation of a word" do
    batman = Quiz.new "Batman"
    expect(batman.represent).to eq("______")

    dog = Quiz.new "Dog"
    expect(dog.represent).to eq("___")
  end

  it "accepts a letter as guess and returns true" do
    batman = Quiz.new "Batman"

    expect(batman.guess!("m")).to eq(true)
    expect(batman.represent).to eq("___m__")
  end

  it "accepts letter insensitive of case" do
    batman = Quiz.new "Batman"

    expect(batman.guess!("b")).to eq(true)
    expect(batman.represent).to eq("B_____")

    expect(batman.guess!("t")).to eq(true)
    expect(batman.represent).to eq("B_t___")
  end

  it "adds a letter to the guessed list once guessed" do
    batman = Quiz.new "Batman"
    batman.guess! "m"

    expect(batman.guessed).to eq(["m"])
  end

  it "returns false if a letter is guessed twice and doesn't add it again" do
    batman = Quiz.new "Batman"
    batman.guess! "m"

    expect(batman.guess!("m")).to eq(false)
    expect(batman.guessed).to eq(["m"])
  end

  it "reveals all occurrences of a letter" do
  end
end
