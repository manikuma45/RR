require 'rails_helper'

RSpec.describe Learning, type: :model do

  it "項目名、本文、備考、URLが入力されれば登録できる" do
    expect(FactoryBot.create(:learning)).to be_valid
  end

  it "項目名が無ければ登録できない" do
    expect(FactoryBot.build(:learning, title: "")).to_not be_valid
  end

  it "項目名が1000文字を超えると登録できない" do
    expect(FactoryBot.build(:learning, title: "test" *1000)).to_not be_valid
  end

  it "本文が1000文字を超えると登録できない" do
    expect(FactoryBot.build(:learning, main_content: "test" *1000)).to_not be_valid
  end

  it "備考が1000文字を超えると登録できない" do
    expect(FactoryBot.build(:learning, sub_content: "test" *1000)).to_not be_valid
  end

  it "URLが1000文字を超えると登録できない" do
    expect(FactoryBot.build(:learning, url_info: "test" *1000)).to_not be_valid
  end

  # it "画像保存パスが1000文字を超えると登録できない" do
  #   expect(FactoryBot.build(:learning, image: "test" *1000)).to_not be_valid
  # end

end
