# frozen_string_literal: true

FactoryBot.define do
  factory :learning do
    title { 'Factoryで作った学習項目名1' }
    main_content { 'Factoryで作った学習内容1-1' }
    sub_content { 'Factoryで作った学習内容1-2' }
    url_info { 'https://diver.diveintocode.jp/submissions/20163' }
    created_on { '2020-04-27' }
    checked_times { 0 }
    reappearance_date { '' }
    association :user
  end

  trait :learning_with_labels do
    after(:build) do |_user|
      learning.labels << build(:label)
    end
  end
end
