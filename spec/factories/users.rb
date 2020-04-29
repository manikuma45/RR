# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:id) { |n| }
    sequence(:name, 'name_1')
    sequence(:email) { |n| "sample#{n}@sample.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
