require "rails_helper"

RSpec.describe Array do
  describe ".promote" do
    subject(:array) { [1, 2, 3] }

    it { expect(array.promote(2)).to eq [2, 1, 3] }
    it { expect(array.promote(3)).to eq [3, 1, 2] }
    it { expect(array.promote(4)).to eq [1, 2, 3] }
    it { expect((array + array).promote(2)).to eq [2, 1, 3, 1, 2, 3] }
  end
end
