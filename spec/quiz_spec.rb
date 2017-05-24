require "spec_helper"

RSpec.describe Quiz do
  it "shows a representation of a word" do
    batman = Quiz.new "Batman"
    expect(batman.represent).to eq("______")

    dog = Quiz.new "Dog"
    expect(dog.represent).to eq("___")
  end

  it "accepts a letter as guess" do
    batman = Quiz.new "Batman"
    batman.guess! "m"

    expect(batman.represent).to eq("___m__")
  end
end
