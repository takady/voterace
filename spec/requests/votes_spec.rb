require 'rails_helper'

RSpec.describe '/votes', type: :request do
  describe 'POST /votes' do
    let(:attr) { attributes_for :vote }
    let(:created_vote) { Vote.where(candidate: attr[:candidate]).first }

    before do
      post votes_path, { vote: attr }
    end

    it { expect(response).to have_http_status(201) }
    it { expect(created_vote.candidate).to eq(attr[:candidate]) }
  end

  describe 'PUT /votes/:id' do
    let(:vote) { create :vote, candidate: 1 }
    let(:modified_candidate) { 2 }

    before do
      put vote_path(vote), { vote: { candidate: modified_candidate } }
    end

    it { expect(response).to have_http_status(200) }
    it { expect(Vote.find(vote.id).candidate).to eq(modified_candidate) }
  end
end
