FactoryBot.define do
  factory :task do
    title "MyString"
    description "MyText"
    status :pending

    factory :task_started do
      status Task.statuses[:started]
    end
  end
end
