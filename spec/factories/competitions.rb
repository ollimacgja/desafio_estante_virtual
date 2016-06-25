FactoryGirl.define do
  factory :competition do
    name 'Competição'
    competition_type 'dart'
    finished false

    trait :dart_competition do
      name 'Bullseye Darts'
      competition_type 'dart'
      transient do
        results_count 3
      end
    end

    trait :dash_competition do
      name 'Bolt Dash'
      competition_type 'dash'
      transient do
        results_count 1
      end
    end

    trait :finished do
      finished true
    end

    trait :complete_results do
      before(:create) do |competition, evaluator|
        [:john_doe, :joe_smith, :adam_west].each do |athlete|
          create_list(:result, evaluator.results_count, competition: competition, athlete: create(athlete))
        end
      end
    end

    trait :incomplete_results do
      after(:create) do |competition, evaluator|
        [:john_doe, :joe_smith, :adam_west].each do |athlete|
          create_list(:result, evaluator.results_count - 1, competition: competition, athlete: create(athlete))
        end
      end
    end

    factory :dart_competition, traits: [:dart_competition]
    factory :dart_complete_competition, traits: [:dart_competition, :complete_results]
    factory :dart_incomplete_competition, traits: [:dart_competition, :incomplete_results]
    factory :dash_competition, traits: [:dash_competition]
    factory :dash_complete_competition, traits: [:dash_competition, :complete_results]
    factory :finished_dart_competition,    traits: [:dart_competition, :finished]
    factory :finished_dash_competition,    traits: [:dash_competition, :finished]
    # factory :finished_dart_complete_competition,    traits: [:dart_competition, :complete_results, :finished]
    # factory :finished_dash_complete_competition,    traits: [:dash_competition, :complete_results, :finished]
  end
end
