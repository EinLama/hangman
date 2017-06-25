require "spec_helper"

RSpec.describe Diagram do
  let(:dead) {
    x = <<-EOF
      ______
      |/   |
      |    o
      |   /|\\
      |   / \\
      |
      --------
    EOF

    x.split("\n").map(&:strip).join("\n")
  }

  let(:empty_gallow) {
      x = <<-EOF
      ______
      |/
      |
      |
      |
      |
      --------
    EOF

    x.split("\n").map(&:strip).join("\n")
  }

  let(:one_miss) {
    x = <<-EOF
      ______
      |/   |
      |
      |
      |
      |
      --------
    EOF

    x.split("\n").map(&:strip).join("\n")
  }
  let(:two_misses) {
    x = <<-EOF
      ______
      |/   |
      |    o
      |
      |
      |
      --------
    EOF

    x.split("\n").map(&:strip).join("\n")
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
    expect(diagram.strokes).to eq(4)
    expect(diagram).to be_complete
  end
end
