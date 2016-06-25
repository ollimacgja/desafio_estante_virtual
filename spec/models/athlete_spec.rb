require 'rails_helper'

RSpec.describe Athlete, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should have_many(:results) }
  it { should have_many(:competitions).through(:results).conditions(:uniq) }
end
