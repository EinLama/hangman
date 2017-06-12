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

  let(:diagram) { Diagram.new }

  it "starts with the gallows" do
    expect(diagram.to_s).to eq(empty_gallow)
    expect(diagram.empty!.to_s).to eq(empty_gallow)
  end

  it "can draw a dead man" do
    expect(diagram.dead!.to_s).to eq(dead)
  end

  it "can draw one miss" do
    diagram.next_step!
    expect(diagram.to_s).to eq(one_miss)
  end
end
