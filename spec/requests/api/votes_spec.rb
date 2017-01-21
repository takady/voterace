require 'rails_helper'

RSpec.describe 'Votes', type: :request do
  let(:user) { create(:user) }

  # TODO fix
  before do
    allow_any_instance_of(Api::ApiController).to receive(:current_user).and_return(user)
  end

  describe 'POST /api/races/:race_id/vote' do
    let(:race) { create(:race, number_of_candidates: 2) }

    subject {
      post api_race_vote_path(race_id: race.id),
           params: {candidate_order: candidate_order},
           as: :json
    }

    context 'The user votes for the race for the first time' do
      context 'Valid parameter' do
        let(:candidate_order) { 1 }

        it { is_expected.to eq(200) }
        it { expect { subject }.to change { Vote.count }.by(1) }
      end

      context 'Vote for not exist candidate order' do
        let(:candidate_order) { 3 }

        it { is_expected.to eq(404) }
        it { expect { subject }.not_to change { Vote.count } }
      end
    end

    context 'The user already voted for the race' do
      let(:voted_candidate) { race.candidates.find_by(order: 1) }

      before do
        user.vote_for(voted_candidate)
      end

      context 'The user vote for another candidate' do
        let(:candidate_order) { 2 }

        it { is_expected.to eq(200) }
        it { expect { subject }.not_to change { Vote.count } }
        it { expect { subject }.to change {
          Vote.find_by(race_id: race.id, user_id: user.id).candidate.order
        }.from(1).to(2) }
      end
    end
  end
end
