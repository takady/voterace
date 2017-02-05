require 'rails_helper'

RSpec.describe 'Votes', type: :request do
  let(:user) { create(:user) }
  let(:race_owner) { create(:user) }
  let(:race) { create(:race, number_of_candidates: 2, user: race_owner) }

  # TODO fix
  before do
    allow_any_instance_of(Api::ApiController).to receive(:current_user).and_return(user)
  end

  describe 'POST /api/candidates/:candidate_id/vote' do
    subject {
      post api_candidate_vote_path(candidate_id: candidate_id), as: :json
    }

    context 'The user votes for the candidate for the first time' do
      context 'Valid parameter' do
        let(:candidate_id) { race.candidates.find_by(order: 1).id }

        it { is_expected.to eq(200) }
        it { expect { subject }.to change { Vote.count }.by(1) }
      end

      context 'Vote for not exist candidate' do
        let(:candidate_id) { race.candidates.find_by(order: 2).id + 1 }

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
        let(:candidate_id) { race.candidates.find_by(order: 2).id }

        it { is_expected.to eq(200) }
        it { expect { subject }.not_to change { Vote.count } }
        it { expect { subject }.to change {
          Vote.find_by(race_id: race.id, user_id: user.id).candidate.order
        }.from(1).to(2) }
      end
    end
  end
end
