class Athlete < ActiveRecord::Base

  has_many :results
  has_many :competitions, -> { uniq }, through: :results

  validates_presence_of :name
  validates_uniqueness_of :name

end
