require 'rails_helper'

RSpec.describe Competition, type: :model do
  it { should enumerize(:competition_type).in(:dart, :dash).with_predicates(true) }
  it { should have_many(:results).dependent(:destroy) }
  it { should have_many(:athletes).through(:results).conditions(:uniq) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:competition_type) }

  describe '#finish_competition' do
    context 'Not finished Competition' do
      let(:competition) { FactoryGirl.create(:dart_competition) }
      it { expect { competition.finish_competition }.to change(competition, :finished) }
    end
    context 'Finished Competition' do
      let(:competition) { FactoryGirl.create(:finished_dart_competition) }
      it { expect { competition.finish_competition }.not_to change(competition, :finished) }
    end
  end

  context 'Rank' do
    let(:athlete_1) { FactoryGirl.create(:usain_bolt) }
    let(:athlete_2) { FactoryGirl.create(:adam_west) }
    let(:competition) { FactoryGirl.create(:dash_competition) }
    let!(:result_1) { FactoryGirl.create(:dash_result, competition: competition, athlete: athlete_1, value: 9.58) }
    let!(:result_2) { FactoryGirl.create(:dash_result, competition: competition, athlete: athlete_2) }

    describe '#ordered_results' do
      it { expect(competition.ordered_results).to eq(athlete_1.name => 9.58, athlete_2.name => result_2.value) }
    end

    describe '#ranking' do
      it 'expect to build ordered ranking' do
        expect(competition.ranking).to eq(
          1 => { name: athlete_1.name, value: 9.58, unit: competition.competition_unit },
          2 => { name: athlete_2.name, value: result_2.value, unit: competition.competition_unit }
        )
      end
    end

    describe '#build_ranking_hash' do
      it 'expect to build ranking hash' do
        expect(competition.build_ranking_hash).to eq(
          {
            competition: competition.name,
            finished: competition.finished,
            ranking:
            {
              1 => { name: athlete_1.name, value: 9.58, unit: competition.competition_unit },
              2 => { name: athlete_2.name, value: result_2.value, unit: competition.competition_unit }
            }
          }.to_json
        )
      end
    end
  end

  describe '#competition_unit' do
    let(:competition) { FactoryGirl.create(:dart_incomplete_competition) }

    it { expect(competition.competition_unit).to eq(competition.results.first.unit_text) }
  end
end
