require 'rails_helper'

RSpec.describe Api::V1::ResultsController, type: :controller do
  describe 'POST /api/v1/result' do
    let!(:competition) { FactoryGirl.create(:dash_competition, name: '100m classificatoria 1') }
    context 'new Result success' do
      before(:each) do
        post :create, format: :json, result: { competition: '100m classificatoria 1', athlete: 'Joao das Neves', value: '10.234', unit: 's' }
      end

      it { expect(response.status).to eq(201) }
      it { expect(Athlete.last.name).to eq('Joao das Neves') }
      it { expect(Result.last.athlete_id).to eq(Athlete.last.id) }
      it { expect(Result.last.competition_id).to eq(competition.id) }
      it { expect(Result.last.value).to eq(10.234) }
      it { expect(Result.last.unit).to eq('s') }
      it { expect(JSON.parse(response.body)['competition_id']).to eq(competition.id) }
      it { expect(JSON.parse(response.body)['value']).to eq(10.234) }
      it { expect(JSON.parse(response.body)['unit']).to eq('s') }
    end

    context 'failed Result' do
      before(:each) do
        post :create, format: :json, result: { competition: '100m classificacao', athlete: 'Joao das Neves', value: '10.234', unit: 's' }
      end

      it { expect(response.status).to eq(500) }
      it { expect(Athlete.count).to eq(0) }
      it { expect(Result.count).to eq(0) }
      it { expect(JSON.parse(response.body)['error']).to eq("Couldn't find Competition") }
    end

    context '#result_params' do
      before(:each) do
        post :create, format: :json, result: { competition: '100m classificacao', athlete: 'Joao das Neves', value: '10.234', unit: 's' }, foo: 'Bar'
      end

      it { expect(controller.send(:result_params).keys).not_to include('foo') }
      it { expect(controller.send(:result_params).keys).to include('competition') }
      it { expect(controller.send(:result_params).keys).to include('athlete') }
      it { expect(controller.send(:result_params).keys).to include('value') }
      it { expect(controller.send(:result_params).keys).to include('unit') }
    end
  end
end
