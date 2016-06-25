FactoryGirl.define do
  factory :athlete do
    name "José das Couves"

    factory :usain_bolt do
      name 'Usain Bolt'
      # Record at 100m Dash = 9.58s
    end

    factory :john_doe do
      name 'John Doe'
    end

    factory :joe_smith do
      name 'Joe Smith'
    end

    factory :adam_west do
      name 'Adam West'
    end

    factory :avarage_joe do
      name 'Avarage Joe'
    end
  end
end
