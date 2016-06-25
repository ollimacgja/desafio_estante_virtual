require 'rails_helper'

RSpec.describe Result, type: :model do
  it { should enumerize(:unit).in(:s, :m) }
  it { should belong_to(:competition) }
  it { should belong_to(:athlete) }
  it { should validate_presence_of(:athlete) }
  it { should validate_presence_of(:competition) }
  it { should validate_presence_of(:value) }
  it { should validate_presence_of(:unit) }

  describe 'Validations' do
    context 'Valid Result' do
      let(:competition) { FactoryGirl.create(:dart_incomplete_competition) }
      let(:result) { FactoryGirl.build(:result, competition: competition, athlete: competition.athletes.first) }

      it { expect(result).to be_valid }
    end

    context 'Invalid Result' do
      describe 'Complete Competition(Not Finished)' do
        let(:competition) { FactoryGirl.create(:dash_complete_competition) }
        let(:result) { FactoryGirl.build(:result, competition: competition, athlete: competition.athletes.first) }

        it { expect(result).not_to be_valid }
        it '#number_of_results' do
          result.valid?
          expect(result.errors[:athlete].size).to eq(1)
        end
      end

      describe 'Complete Competition(Finished)' do
        let(:competition) { FactoryGirl.create(:finished_dart_competition) }
        let(:result) { FactoryGirl.build(:result, competition: competition, athlete: competition.athletes.first) }

        it { expect(result).not_to be_valid }
        it '#can_add_result?' do
          result.valid?
          expect(result.errors[:competition].size).to eq(1)
        end
      end
    end
  end
end
