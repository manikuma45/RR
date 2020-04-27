require 'rails_helper'

RSpec.describe 'Labels', type: :system do

  describe 'ラベル登録画面' do
      before do
        user_a = FactoryBot.create(:user)
        label_1 = FactoryBot.create(:label, label_name: "sample1", id: 1)
        label_2 = FactoryBot.create(:label, label_name: "sample2", id: 2)
        label_3 = FactoryBot.create(:label, label_name: "sample3", id: 3)
      end



        it "１つ追加で１つのラベルが貼られること" do
          visit root_path
          fill_in 'Email', with: 'sample_mail1@sample.com'

          fill_in 'session_password', with: 'password'
          fill_in 'session_password_conf', with: 'password'

          click_on 'Log in'
          visit new_learning_path
          fill_in 'title', with: 'テスト項目１'
          fill_in 'main_content', with: 'テスト内容１'
          check 'sample1'
          click_on '新規登録'
          expect(page).to have_content 'sample1'
      end

        it "ラベルの貼られたタスクだけが画面に残ること" do
          user_b = FactoryBot.create(:user2)
          learning_a = FactoryBot.create(:learning, user: user_b)
          learning_d = FactoryBot.create(:learning2, user: user_b)
          learning_c = FactoryBot.create(:learning2, name: "Factoryで作った学習項目名3", user: user_b)
          labeling_1 = FactoryBot.create(:labeling, learning_id: learning_a.id)
          labeling_2 = FactoryBot.create(:labeling2, learning_id: learning_a.id)
          labeling_3 = FactoryBot.create(:labeling3, learning_id: learning_a.id)
          visit root_path
          fill_in 'Email', with: 'sample_mail2@sample.com'
          fill_in 'session_password', with: 'password'
          fill_in 'session_password_conf', with: 'password'
          click_button 'Log in'
          visit learnings_path
          sleep 0.5
          select 'sample1', from: 'label_id'
          click_on 'search'
          expect(page).to have_content 'Factoryで作った学習項目名1'
          expect(page).to_not have_content 'Factoryで作った学習項目名2'
      end
    end
  end

end
