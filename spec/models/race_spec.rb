require 'rails_helper'

RSpec.describe Race, type: :model do
  describe '#expired_at', freeze_time: true do
    it { expect(build(:race, expired_at: '')).not_to be_valid }
    it { expect(build(:race, expired_at: nil)).not_to be_valid }
    it { expect(build(:race, expired_at: Time.zone.now.ago(1))).not_to be_valid }
    it { expect(build(:race, expired_at: Time.zone.now.since(1))).to be_valid }
  end

  describe '#votable?' do
    context '投票期限が明日の場合' do
      let(:race) { create(:race, expired_at: Time.zone.now.tomorrow) }

      subject { race.votable?(at: at) }

      context '投票期限を過ぎていない場合' do
        let(:at) { Time.zone.now }

        it { is_expected.to eq(true) }
      end

      context '投票期限を過ぎた場合' do
        let(:at) { Time.zone.now.since(2.days) }

        it { is_expected.to eq(false) }
      end
    end
  end
end
