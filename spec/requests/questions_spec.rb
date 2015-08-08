require 'rails_helper'

RSpec.describe '/questions', type: :request do
  describe 'GET /questions' do
    let(:question) { create :question }

    before do
      get questions_path
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'GET /questions/:id' do
    let(:question) { create :question }

    before do
      get question_path(question)
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'POST /questions' do
    let(:attr) { attributes_for :question }
    let(:created_question) { Question.where(title: attr[:title]).first }

    before do
      post questions_path, { question: attr }
    end

    it { expect(response).to have_http_status(201) }
    it { expect(created_question.title).to eq(attr[:title]) }
  end

  describe 'DELETE /questions/:id' do
    let(:question) { create :question }

    before do
      delete question_path(question)
    end

    it { expect(response).to have_http_status(204) }
    it { expect{ Question.find(question.id) }.to raise_error(ActiveRecord::RecordNotFound) }
  end
end
