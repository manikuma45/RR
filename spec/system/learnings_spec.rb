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

RSpec.describe Learning, type: :system do
  # before do
  #   FactoryBot.create_list(:user, 5) do |u|
  #     FactoryBot.create_list(:learning, 5, user: u)
  #   end
  # end
  # before  do
  #   user_a = FactoryBot.create(:user)
  #   @learning = FactoryBot.create(:learning, user_id: user_a.id)
  # end
  it "テストユーザーでログインし、項目の題名を編集する" do

    user_a = FactoryBot.create(:user, name: "name_2", email: "sample2@sample.com")
    learning_a = Learning.create(title: 'Factoryで作った学習項目名1',
                                 main_content: 'Factoryで作った学習内容1-1',
                                 sub_content: 'Factoryで作った学習内容1-2',
                                 url_info: 'https://diver.diveintocode.jp/submissions/20163',
                                 created_on: '2020-04-27',
                                 checked_times: 0,
                                 reappearance_date: '',
                                 user_id: user_a.id
                               )
    visit new_user_session_path
    fill_in 'user_email', with: 'sample2@sample.com'
    fill_in 'user_password', with: 'password'
    click_on 'ログインする'
    # binding.irb
    click_on '編集'
    fill_in 'learning_title', with: '編集済み'
    click_button '12'
    expect(page).to have_content '編集済み'
    binding.irb
  end


end
