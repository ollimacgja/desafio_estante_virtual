require 'rails_helper'

RSpec.describe Api::V1::CompetitionsController, type: :controller do
  describe 'POST /api/v1/competition' do
    context 'new Competition success' do
      before(:each) do
        post :create, format: :json, competition: { name: '100m classificatoria 1', competition_type: 'dash' }
      end

      it { expect(response.status).to eq(201) }
      it { expect(Competition.count).to eq(1) }
      it { expect(Competition.last.name).to eq('100m classificatoria 1') }
      it { expect(JSON.parse(response.body)['name']).to eq('100m classificatoria 1') }
      it { expect(JSON.parse(response.body)['competition_type']).to eq('dash') }
    end

    context 'failed Result' do
      let!(:competition) { FactoryGirl.create(:competition, name: '100m classificatoria 1') }
      before(:each) do
        post :create, format: :json, competition: { name: '100m classificatoria 1', competition_type: 'dash' }
      end

      it { expect(response.status).to eq(422) }
      it { expect(Competition.count).to eq(1) }
      it { expect(JSON.parse(response.body)).to eq('errors' => { 'name' => ['has already been taken'] }) }
    end

    context '#competition_params' do
      before(:each) do
        post :create, format: :json, competition: { name: '100m classificatoria 1', competition_type: 'dash' }, foo: 'Bar'
      end

      it { expect(controller.send(:competition_params).keys).not_to include('foo') }
      it { expect(controller.send(:competition_params).keys).to include('name') }
      it { expect(controller.send(:competition_params).keys).to include('competition_type') }
    end
  end

  describe 'POST /api/v1/competition/ranking' do
    let!(:competition) { FactoryGirl.create(:dart_complete_competition, name: 'Dardos classificatoria 1') }

    context 'ranking success' do
      before(:each) do
        post :ranking, format: :json, competition: { name: 'Dardos classificatoria 1' }
      end

      it { expect(response.status).to eq(200) }
      it { expect(response.body).to eq(competition.build_ranking_hash) }
    end

    context 'ranking fail' do
      before(:each) do
        post :ranking, format: :json, competition: { name: 'Dardos classificatoria' }
      end

      it { expect(response.status).to eq(500) }
      it { expect(JSON.parse(response.body)['error']).to eq("Couldn't find Competition") }
    end
  end

  describe 'POST /api/v1/competition/finish_competition' do
    let!(:competition) { FactoryGirl.create(:dart_complete_competition, name: 'Dardos classificatoria 1') }

    context 'finish success' do
      before(:each) do
        post :finish_competition, format: :json, competition: { name: 'Dardos classificatoria 1' }
      end

      it { expect(response.status).to eq(200) }
      it { expect(response.body).to eq('Finished Competition') }
    end
  end
end
