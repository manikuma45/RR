FactoryBot.define do
  factory :learning do
    title { 'Factoryで作った学習項目名1' }
    main_content { 'Factoryで作った学習内容1-1' }
    sub_content { 'Factoryで作った学習内容1-2' }
    expired { '2020-06-01' }
    status { '未着手' }
    priority { '低' }
    association :user
end
  factory :learning2, class: Task do
    title { 'Factoryで作った学習項目名2' }
    main_content { 'Factoryで作った学習内容2-1' }
    sub_content { 'Factoryで作った学習内容2-2' }
    expired { '2025-06-01' }
    status { '完了' }
    priority { '高' }
    association :user
end
    factory :learning3, class: Task do
      title { 'Factoryで作った学習項目名3' }
      main_content { 'Factoryで作った学習内容3-1'}
      sub_content { 'Factoryで作った学習内容3-2' }
      expired { '2030-10-01' }
      status { '着手中' }
      priority { '中' }
      association :user
end

factory :learning4, class: Task do
  title { 'Factoryで作った学習項目名4' }
  main_content { 'Factoryで作った学習内容4-1' }
  sub_content { 'Factoryで作った学習内容4-2' }
  expired { '2030-12-31' }
  status { '着手中' }
  priority { '中' }
  association :user
end

# factory :learning5, class: Task do
#   title { 'Factoryで作った学習項目名4' }
#   main_content { 'Factoryで作った学習内容4' }
#   expired { '2030-12-31' }
#   status { '着手中' }
#   priority { '中' }
#   label {'sample1'}
#   association :user
# end
#
# factory :learning6, class: Task do
#   title { 'Factoryで作った学習項目名4' }
#   main_content { 'Factoryで作った学習内容4' }
#   expired { '2030-12-31' }
#   status { '着手中' }
#   priority { '中' }
#   label {'sample2'}
#   association :user
# end

trait :learning_with_labels do
  after(:build) do |user|
    learning.labels << build(:label)
  end
end

end
