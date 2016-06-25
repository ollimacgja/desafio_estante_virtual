FactoryGirl.define do
  factory :result do
    competition
    athlete factory: :john_doe
    value { rand(90.00..150.00).round(2) }
    unit 'm'

    factory :dart_result do
      value { rand(90.00..150.00).round(2) }
      unit 'm'
    end

    factory :dash_result do
      value { rand(9.59..15.00).round(2) }
      unit 's'
    end
  end
end
