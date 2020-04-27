FactoryBot.define do
  factory :user do
    id { 1 }
    sequence(:name, "name_1")
    sequence(:email, "sample_mail1@sample.com")
    password{"password"}
    password_confirmation{"password"}
  end

  factory :user2, class: User do
    id { 2 }
    sequence(:name, "name_2")
    sequence(:email, "sample_mail2@sample.com")
    password{"password"}
    password_confirmation{"password"}
  end

  # factory :admin_user, class: User do
  #   id { 2 }
  #   name { 'admin' }
  #   email { 'admin@example.com' }
  #   password { '00000000' }
  #   admin { true }
  # end

end
