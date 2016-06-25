class Competition < ActiveRecord::Base
  extend Enumerize

  enumerize :competition_type, in: [:dart, :dash], predicates: true

  has_many :results, dependent: :destroy
  has_many :athletes, -> { uniq }, through: :results

  validates_presence_of :name, :competition_type
  validates_uniqueness_of :name
  validate :can_end_competition?, if: :finished?, unless: :dash?

  def can_end_competition?
    errors.add(:finished, :cannot_end) if results.count < athletes.count * 3
  end

  def finish_competition
    self.finished = true
  end

  def ordered_results
    unordered = {}
    athletes.each do |athlete|
      unordered = unordered.merge(athlete.name => athlete.results.where(competition: self).maximum(:value))
    end
    dart? ? unordered.sort_by { |_k, v| v }.reverse.to_h : unordered.sort_by { |_k, v| v }.to_h
  end

  def ranking
    rank = {}
    ordered_results.each_with_index do |hash, i|
      rank = rank.merge(i + 1 => { name: hash[0], value: hash[1], unit: competition_unit })
    end
    rank
  end

  def build_ranking_hash
    {
      competition: name,
      finished: finished,
      ranking: ranking
    }.to_json
  end

  def competition_unit
    results.first.unit_text
  end
end
