require 'rails_helper'

RSpec.describe Concerns::PercentageCalculable, type: :model do
  describe '#percents_of' do
    let(:model) { Struct.new(:dummy).extend(Concerns::PercentageCalculable) }

    it { expect(model.percents_of([0, 0])).to eq([0, 0]) }
    it { expect(model.percents_of([0, 1])).to eq([0, 100]) }
    it { expect(model.percents_of([1, 0])).to eq([100, 0]) }
    it { expect(model.percents_of([1, 2])).to eq([33, 67]) }
    it { expect(model.percents_of([1, 2, 3])).to eq([17, 33, 50]) }

    describe 'In some cases, total of results is not be 100%.' do
      it { expect(model.percents_of([1, 7]).sum).to eq(101) }
      it { expect(model.percents_of([1, 39]).sum).to eq(101) }
      it { expect(model.percents_of([2, 14]).sum).to eq(101) }
    end
  end
end
