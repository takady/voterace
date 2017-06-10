require 'rails_helper'

RSpec.describe 'Races', type: :request do
  let(:user) { create(:user) }

  # TODO fix
  before do
    allow_any_instance_of(Api::ApiController).to receive(:current_user).and_return(user)
  end

  describe 'POST /api/races' do
    let(:title) { 'Title' }
    let(:expired_at) { Time.current + 1.month }
    let(:candidates) { %w(one two) }

    subject {
      post api_races_path,
           params: {
             title: title,
             expired_at: expired_at,
             candidates: candidates
           },
           as: :json
    }

    context 'Valid parameter' do
      it { is_expected.to eq(201) }
      it { expect { subject }.to change { Race.count }.by(1).and change { Candidate.count }.by(2) }
    end

    context 'blank title' do
      let(:title) { '' }

      it { is_expected.to eq(400) }
      it {
        expect { subject }.not_to change { Race.count }
        expect { subject }.not_to change { Candidate.count }
      }
    end

    context 'less than two candidates' do
      let(:candidates) { %w(one) }

      it { is_expected.to eq(400) }
      it {
        expect { subject }.not_to change { Race.count }
        expect { subject }.not_to change { Candidate.count }
      }
    end
  end
end
