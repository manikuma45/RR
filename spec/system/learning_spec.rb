# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Learning, type: :model do
  it '項目名、本文、備考、URLが入力されれば登録できる' do
    expect(FactoryBot.create(:learning)).to be_valid
  end

  it '項目名が無ければ登録できない' do
    expect(FactoryBot.build(:learning, title: '')).to_not be_valid
  end

  it '項目名が1000文字を超えると登録できない' do
    expect(FactoryBot.build(:learning, title: 'test' * 1000)).to_not be_valid
  end

  it '本文が1000文字を超えると登録できない' do
    expect(FactoryBot.build(:learning, main_content: 'test' * 1000)).to_not be_valid
  end

  it '備考が1000文字を超えると登録できない' do
    expect(FactoryBot.build(:learning, sub_content: 'test' * 1000)).to_not be_valid
  end

  it 'URLが1000文字を超えると登録できない' do
    expect(FactoryBot.build(:learning, url_info: 'test' * 1000)).to_not be_valid
  end
end

RSpec.describe Learning, type: :system do
  it 'テストユーザーでログインし、項目を新規作成する' do
    FactoryBot.create(:user, name: 'name_2', email: 'sample2@sample.com')
    FactoryBot.create(:label)
    visit new_user_session_path
    fill_in 'user_email', with: 'sample2@sample.com'
    fill_in 'user_password', with: 'password'
    click_on 'ログインする'
    click_on 'new item'
    fill_in 'learning_title', with: 'テスト項目１'
    fill_in 'learning_main_content', with: 'テスト本文１'
    fill_in 'learning_sub_content', with: 'テスト備考１'
    fill_in 'learning_url_info', with: 'https://translate.google.co.jp/?hl=ja&tab=TT'
    check 'label1'
    click_button '12'
    expect(page).to have_content 'テスト項目１'
    expect(page).to have_content 'URL'
    expect(page).to have_content 'label1'
    click_button '本文を読む'
    expect(page).to have_content 'テスト本文１'
    expect(page).to have_content 'テスト備考１'
  end

  it 'テストユーザーでログインし、項目の題名を項目編集画面で更新する' do
    user_a =FactoryBot.create(:user, name: 'name_2', email: 'sample2@sample.com')
    Learning.create(title: 'テスト学習項目名1',
                                 main_content: 'テスト学習内容1-1',
                                 sub_content: 'テスト学習内容1-2',
                                 url_info: 'https://diver.diveintocode.jp/submissions/20163',
                                 created_on: '2020-04-27',
                                 checked_times: 0,
                                 reappearance_date: '',
                                 user_id: user_a.id)
    visit new_user_session_path
    fill_in 'user_email', with: 'sample2@sample.com'
    fill_in 'user_password', with: 'password'
    click_on 'ログインする'
    click_on '編集'
    fill_in 'learning_title', with: '編集済み'
    click_button '12'
    expect(page).to have_content '編集済み'
  end

  it 'テストユーザーでログインし、項目を削除する' do
    user_a = FactoryBot.create(:user, name: 'name_2', email: 'sample2@sample.com')
    Learning.create(title: 'テスト学習項目名1',
                                 main_content: 'テスト学習内容1-1',
                                 sub_content: 'テスト学習内容1-2',
                                 url_info: 'https://diver.diveintocode.jp/submissions/20163',
                                 created_on: '2020-04-27',
                                 checked_times: 0,
                                 reappearance_date: '',
                                 user_id: user_a.id)
    visit new_user_session_path
    fill_in 'user_email', with: 'sample2@sample.com'
    fill_in 'user_password', with: 'password'
    click_on 'ログインする'
    click_on '削除'
    page.accept_confirm '項目テスト学習項目名1を削除します'
    expect(page).to_not have_content 'テスト学習項目名1'
  end

  it 'テストユーザーでログインし、項目をチェックし、再学習ボタンで一覧に戻す' do
    user_a = FactoryBot.create(:user, name: 'name_2', email: 'sample2@sample.com')
    Learning.create(title: 'テスト学習項目名1',
                                 main_content: 'テスト学習内容1-1',
                                 sub_content: 'テスト学習内容1-2',
                                 url_info: 'https://diver.diveintocode.jp/submissions/20163',
                                 created_on: '2020-05-01',
                                 checked_times: 0,
                                 reappearance_date: '',
                                 user_id: user_a.id)
    visit new_user_session_path
    fill_in 'user_email', with: 'sample2@sample.com'
    fill_in 'user_password', with: 'password'
    click_on 'ログインする'
    click_on 'チェック'
    expect(page).to have_content '次回学習日 2020-05-02'
    expect(page).to_not have_content 'テスト学習項目名1'
    visit history_learnings_path
    expect(page).to have_content 'テスト学習項目名1'
    expect(page).to have_content 'チェック回数：1'
    click_on '再学習'
    page.accept_confirm '項目テスト学習項目名1を再学習します'
    expect(page).to have_content 'チェック回数：0'
  end

  it '項目名で検索ができる' do
    user_a = FactoryBot.create(:user, name: 'name_2', email: 'sample2@sample.com')
    learning_a = Learning.create(title: 'テスト学習項目名1',
                                 user_id: user_a.id)
    learning_b = Learning.create(title: 'テスト学習項目名2',
                                 user_id: user_a.id)
    visit new_user_session_path
    fill_in 'user_email', with: 'sample2@sample.com'
    fill_in 'user_password', with: 'password'
    click_on 'ログインする'
    visit history_learnings_path
    fill_in 'q_title_or_main_content_or_sub_content_or_labels_label_name_cont', with: '項目名1'
    click_on '検索'
    expect(page).to have_content 'テスト学習項目名1'
    expect(page).to_not have_content 'テスト学習項目名2'
  end

  it '本文内容で検索ができる' do
    user_a = FactoryBot.create(:user, name: 'name_2', email: 'sample2@sample.com')
    label_a = FactoryBot.create(:label)
    learning_a = Learning.create(title: 'テスト学習項目名1',
                                 main_content: 'テスト学習内容1-1',
                                 user_id: user_a.id)
    learning_b = Learning.create(title: 'テスト学習項目名2',
                                 main_content: 'テスト学習内容1-2',
                                 user_id: user_a.id)
    visit new_user_session_path
    fill_in 'user_email', with: 'sample2@sample.com'
    fill_in 'user_password', with: 'password'
    click_on 'ログインする'
    visit history_learnings_path
    fill_in 'q_title_or_main_content_or_sub_content_or_labels_label_name_cont', with: '1-1'
    click_on '検索'
    expect(page).to have_content 'テスト学習項目名1'
    expect(page).to_not have_content 'テスト学習項目名2'
  end

  it 'ラベル名で検索ができる' do
    user_a = FactoryBot.create(:user, name: 'name_2', email: 'sample2@sample.com')
    learning_a = Learning.create(title: 'テスト学習項目名1',
                                 main_content: 'テスト学習内容1-1',
                                 user_id: user_a.id)
    FactoryBot.create(:label)
    visit new_user_session_path
    fill_in 'user_email', with: 'sample2@sample.com'
    fill_in 'user_password', with: 'password'
    click_on 'ログインする'
    click_on 'new item'
    fill_in 'learning_title', with: 'テスト学習項目名2'
    check 'label1'
    click_button '12'
    visit history_learnings_path
    fill_in 'q_title_or_main_content_or_sub_content_or_labels_label_name_cont', with: 'label1'
    click_on '検索'
    expect(page).to have_content 'テスト学習項目名2'
    expect(page).to_not have_content 'テスト学習項目名1'
  end
end
