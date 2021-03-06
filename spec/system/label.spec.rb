# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Label, type: :model do
  it '付箋名があれば登録できる' do
    expect(FactoryBot.create(:label_name)).to be_valid
  end

  it '付箋名が無いと登録できない' do
    expect(FactoryBot.build(:label, label_name: '')).to_not be_valid
  end

  # 検索機能のテストはlearning.spec.rbに記載
end
