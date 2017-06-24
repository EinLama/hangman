require "spec_helper"

RSpec.describe Diagram do
  let(:dead) {
    <<-EOF
      ______
      |/   |
      |    o
      |   /|\
      |   / \
      |
      --------
    EOF
  }

  let(:empty_gallow) {
      <<-EOF
      ______
      |/
      |
      |
      |
      |
      --------
    EOF
  }

  let(:one_miss) {
    <<-EOF
      ______
      |/   |
      |
      |
      |
      |
      --------
    EOF
  }
  let(:two_misses) {
    <<-EOF
      ______
      |/   |
      |    o
      |
      |
      |
      --------
    EOF
  }

  let(:diagram) { Diagram.new }

  it "starts with the gallows" do
    expect(diagram.to_s).to eq(empty_gallow.strip)
    expect(diagram.empty!.to_s).to eq(empty_gallow.strip)
  end

  it "can draw a dead man" do
    expect(diagram.dead!.to_s).to eq(dead.strip)
  end

  it "can draw one miss" do
    diagram.next_stroke!
    expect(diagram.to_s).to eq(one_miss.strip)
    expect(diagram.strokes).to eq(1)
  end

  it "can draw two misses" do
    diagram.next_stroke!
    diagram.next_stroke!
    expect(diagram.to_s).to eq(two_misses.strip)
    expect(diagram.strokes).to eq(2)
  end

  it "does not add more strokes after last" do
    diagram.dead!.next_stroke!.next_stroke!

    expect(diagram.to_s).to eq(dead.strip)
    expect(diagram.strokes).to eq(6)
    expect(diagram).to be_complete
  end
end
