require 'rails_helper'

RSpec.describe '/api/users', type: :request do
  describe 'GET /api/users/:id' do
    let(:user) { create :user }

    before do
      get api_user_path(user)
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'POST /api/users' do
    let(:attr) { attributes_for :user }
    let(:created_user) { User.where(name: attr[:name]).first }

    before do
      post api_users_path, { user: attr }
    end

    it { expect(response).to have_http_status(201) }
    it { expect(created_user.email).to eq(attr[:email]) }
  end

  describe 'PUT /api/users/:id' do
    let(:user) { create :user, email: 'sample@example.com' }
    let(:modified_email) { 'modified@example.com' }

    before do
      put api_user_path(user), { user: { email: modified_email } }
    end

    it { expect(response).to have_http_status(200) }
    it { expect(User.find(user.id).email).to eq(modified_email) }
  end

  describe 'DELETE /api/users/:id' do
    let(:user) { create :user }

    before do
      delete api_user_path(user)
    end

    it { expect(response).to have_http_status(204) }
    it { expect{ User.find(user.id) }.to raise_error(ActiveRecord::RecordNotFound) }
  end
end
