require 'rails_helper'

describe Ship do
  subject { Ship.new({'ship_size' => 3,
                      'start_space' => 'A1',
                       'end_space' => 'A3'}) }

  it "initializes with attributes" do
    expect(subject.length).to eq(3)
    expect(subject.damage).to eq(0)
    expect(subject.start_space).to eq('A1')
    expect(subject.end_space).to eq('A3')
  end

  describe 'instance_methods' do
    context '#attack!' do
      it "increases the ship damage by one" do
        subject.attack!

        expect(subject.damage).to eq(1)

        subject.attack!

        expect(subject.damage).to eq(2)
      end
    end

    context "#is_sunk?" do
      it "returns true if damage = length" do
        expect(subject.is_sunk?).to eq(false)

        subject.attack!
        subject.attack!
        expect(subject.is_sunk?).to eq(false)

        subject.attack!
        expect(subject.is_sunk?).to eq(true)
      end
    end
  end
end
