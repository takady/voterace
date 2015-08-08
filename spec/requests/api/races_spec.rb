require 'rails_helper'

RSpec.describe '/api/races', type: :request do
  describe 'GET /api/races' do
    let(:race) { create :race }

    before do
      get api_races_path
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'GET /api/races/:id' do
    let(:race) { create :race }

    before do
      get api_race_path(race)
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'POST /api/races' do
    let(:attr) { attributes_for :race }
    let(:created_race) { Race.where(title: attr[:title]).first }

    before do
      post api_races_path, { race: attr }
    end

    it { expect(response).to have_http_status(201) }
    it { expect(created_race.title).to eq(attr[:title]) }
  end

  describe 'DELETE /api/races/:id' do
    let(:race) { create :race }

    before do
      delete api_race_path(race)
    end

    it { expect(response).to have_http_status(204) }
    it { expect{ Race.find(race.id) }.to raise_error(ActiveRecord::RecordNotFound) }
  end
end
