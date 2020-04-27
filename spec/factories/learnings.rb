FactoryBot.define do

  factory :learning do
    title { 'Factoryで作った学習項目名1' }
      main_content { 'Factoryで作った学習内容1-1' }
      sub_content { 'Factoryで作った学習内容1-2' }
      url_info { 'https://diver.diveintocode.jp/submissions/20163' }
      created_on { '2020-04-27' }
      checked_times { 0 }
      reappearance_date { '' }
      # image { 'https://diver.diveintocode.jp/submissions/20163' }
      association :user
  end

  # factory :learning2, do
  #   title { 'Factoryで作った学習項目名2' }
  #   main_content { 'Factoryで作った学習内容2-1' }
  #   sub_content { 'Factoryで作った学習内容2-2' }
  #   url_info { 'https://translate.google.co.jp/?hl=ja&tab=TT' }
  #   created_on { '2020-04-28' }
  #   checked_times { 0 }
  #   reappearance_date { '' }
  #   association :user
  # end
  #
  # factory :learning3, do
  #   title { 'Factoryで作った学習項目名3' }
  #   main_content { 'Factoryで作った学習内容3-1'}
  #   sub_content { 'Factoryで作った学習内容3-2' }
  #   # url_info { '2030-10-01' }
  #   created_on { '2020-04-26' }
  #   checked_times { 1 }
  #   reappearance_date { '2020-04-27' }
  #   association :user
  # end
  #
  # factory :learning4, do
  #   title { 'Factoryで作った学習項目名4' }
  #   main_content { 'Factoryで作った学習内容4-1' }
  #   sub_content { 'Factoryで作った学習内容4-2' }
  #   # url_info { '2030-12-31' }
  #   created_on { '2020-03-27' }
  #   checked_times { 5 }
  #   reappearance_date { '2020-04-27' }
  #   association :user
  # end

# factory :learning5,  do
#   title { 'Factoryで作った学習項目名4' }
#   main_content { 'Factoryで作った学習内容4' }
#   url_info { '2030-12-31' }
#   created_on { '2020-04-27' } { '着手中' }
#   checked_times { '中' }
#   label {'sample1'}
#   association :user
# end
#
# factory :learning6,  do
#   title { 'Factoryで作った学習項目名4' }
#   main_content { 'Factoryで作った学習内容4' }
#   url_info { '2030-12-31' }
#   created_on { '2020-04-27' } { '着手中' }
#   checked_times { '中' }
#   label {'sample2'}
#   association :user
# end

  trait :learning_with_labels do
    after(:build) do |user|
      learning.labels << build(:label)
  end
end

end
