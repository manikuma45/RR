# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it '名前、メールアドレス、パスワード、パスワード確認が入力されれば登録できる' do
    expect(FactoryBot.create(:user)).to be_valid
  end

  it '名前がなければ登録できない' do
    expect(FactoryBot.build(:user, name: '')).to_not be_valid
  end

  it 'メールアドレスがなければ登録できない' do
    expect(FactoryBot.build(:user, email: '')).to_not be_valid
  end

  it 'メールアドレスが重複していたら登録できない' do
    user1 = FactoryBot.create(:user, name: 'taro', email: 'taro@example.com')
    expect(FactoryBot.build(:user, name: 'jiro', email: user1.email)).to_not be_valid
  end

  it 'パスワードがなければ登録できない' do
    expect(FactoryBot.build(:user, password: '')).to_not be_valid
  end

  it 'password_confirmationとpasswordが異なる場合保存できない' do
    expect(FactoryBot.build(:user, password: 'password', password_confirmation: 'passward')).to_not be_valid
  end
end

RSpec.describe User, type: :system do
  it '必要項目を入力し、ユーザーを新規登録すると、学習項目一覧画面が開く' do
    visit new_user_session_path
    click_on 'ユーザー登録をする'
    fill_in 'user_name', with: 'テストユーザー１'
    fill_in 'user_email', with: 'sample2@sample.com'
    fill_in 'user_password', with: 'sample'
    fill_in 'user_password_confirmation', with: 'sample'
    click_on '新規登録'
    expect(page).to have_content '学習項目一覧'
  end

  it 'ユーザー情報画面からユーザー編集画面を開き、情報を更新する' do
    FactoryBot.create(:user, name: 'name_2', email: 'sample2@sample.com')
    visit new_user_session_path
    fill_in 'user_email', with: 'sample2@sample.com'
    fill_in 'user_password', with: 'password'
    click_on 'ログインする'
    click_on 'ログイン中ユーザー: sample2@sample.com'
    click_on '編集'
    fill_in 'user_name', with: 'テストユーザー１'
    fill_in 'user_email', with: 'sample1@sample.com'
    fill_in 'user_password', with: '111111'
    fill_in 'user_password_confirmation', with: '111111'
    fill_in 'user_current_password', with: 'password'
    click_on '更新'
    expect(page).to have_content 'アカウント情報を変更しました。'
    expect(page).to have_content 'sample1@sample.com'
    expect(page).to_not have_content 'sample2@sample.com'
  end

  it 'ユーザー情報画面からユーザー情報を削除する' do
    FactoryBot.create(:user, name: 'name_2', email: 'sample2@sample.com')
    visit new_user_session_path
    fill_in 'user_email', with: 'sample2@sample.com'
    fill_in 'user_password', with: 'password'
    click_on 'ログインする'
    click_on 'ログイン中ユーザー: sample2@sample.com'
    click_on '編集'
    click_on 'ユーザー情報削除'
    page.accept_confirm 'ユーザー情報を削除し、本サービスの利用を終了してもよいですか？'
    expect(page).to have_content 'アカウント登録もしくはログインしてください。'
  end

  it 'テストユーザーaでログインしても、テストユーザーbの学習項目や情報は参照できない' do
    user_a = FactoryBot.create(:user, name: 'user_a', email: 'sample1@sample.com')
    user_b = FactoryBot.create(:user, name: 'user_b', email: 'sample2@sample.com')
    Learning.create(title: 'テスト学習項目名1',
                    user_id: user_a.id)
    Learning.create(title: 'テスト学習項目名2',
                    user_id: user_b.id)
    visit new_user_session_path
    fill_in 'user_email', with: 'sample1@sample.com'
    fill_in 'user_password', with: 'password'
    click_on 'ログインする'
    click_on 'ログイン中ユーザー: sample1@sample.com'
    expect(page).to_not have_content 'sample2@sample.com'
    expect(page).to_not have_content 'テスト学習項目名2'
    visit learnings_path(user_b.id)
    expect(page).to_not have_content 'テスト学習項目名2'
  end
end
