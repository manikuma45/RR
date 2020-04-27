FactoryBot.define do
  factory :labeling do
    learning_id { 1 }
    label_id { 1 }
  end

  factory :labeling2, class: Labeling do
    learning_id { 2 }
    label_id { 2 }
  end

  factory :labeling3, class: Labeling do
    learning_id { 3 }
    label_id { 3 }
  end
end
