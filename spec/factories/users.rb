FactoryBot.define do
  factory :user do
    sequence(:email) { |n| 'email#{n}@email.com'}
    password 'qwerty123'

    factory :other_user do
      email 'otheruser@mail.com'
    end
  end
end
