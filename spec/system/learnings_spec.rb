require 'rails_helper'

RSpec.describe 'Learnings', type: :system do
  before do

    user_a = FactoryBot.create(:user, name: "name_1", email: "sample_mail1@sample.com")
    visit root_path
    fill_in 'Email', with: 'sample_mail1@sample.com'
    fill_in 'session_password', with: 'password'
    fill_in 'session_password_conf', with: 'password'
    click_on 'Log in'
  end



    it 'データが保存されること' do
      click_on '作業項目一覧'
      click_on '新規作成'
      fill_in 'task_name', with: 'ゴミ出し'
      fill_in 'task_content', with: '不燃ごみを出す'
      click_on '登録する'
      expect(page).to have_content '作業項目を登録しました。'
      expect(page).to have_selector 'p', text: 'ゴミ出し'
      expect(page).to have_selector 'p', text: '不燃ごみを出す'
    end

    it "" do
    end

  end


  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      before do
        user_a = FactoryBot.create(:user, name: "name_1", email: "sample_mail1@sample.com")
        visit root_path
        fill_in 'Email', with: 'sample_mail1@sample.com'
        fill_in 'session_password', with: 'password'
        fill_in 'session_password_conf', with: 'password'
        click_on 'Log in'
      end
      it '作成済みのタスクが表示されること' do
        click_on '作業項目一覧'
        expect(page).to have_selector 'th', text: '作業名'
        expect(page).to have_selector 'th', text: '内容'
      end
    end
  end

  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
       before do
         user_a = FactoryBot.create(:user, name: "name_1", email: "sample_mail1@sample.com")
         visit root_path
         fill_in 'Email', with: 'sample_mail1@sample.com'
         fill_in 'session_password', with: 'password'
         fill_in 'session_password_conf', with: 'password'
         click_on 'Log in'
       end
       it '該当タスクの内容が表示されたページに遷移すること' do
         # click_on '作業項目一覧'
         # click_on '新規作成'
         visit new_task_path
         # save_and_open_page
         fill_in 'task_name', with: '洗濯'
         fill_in 'task_content', with: '布団も干す'
         click_on '登録する'
         click_on '戻る'
         click_on '詳細'
         expect(page).to have_selector 'p', text: '洗濯'
         expect(page).to have_selector 'p', text: '布団も干す'
      end
    end
  end

  describe 'タスク表示降順' do
     context 'タスク複数を作成した場合' do
        before do
          user_a = FactoryBot.create(:user)
          task_a = FactoryBot.create(:task, id: 1, user: user_a)
          task_b = FactoryBot.create(:task2, id: 2, user: user_a, created_at: Time.current + 1.days)
          task_c = FactoryBot.create(:task3, id: 3, user: user_a, created_at: Time.current + 2.days)
          task_d = FactoryBot.create(:task4, id: 4, user: user_a, created_at: Time.current + 3.days)
          visit root_path
          fill_in 'Email', with: 'sample_mail1@sample.com'
          fill_in 'session_password', with: 'password'
          fill_in 'session_password_conf', with: 'password'
          click_on 'Log in'
        end
       it '該当タスクが作成日時の降順で表示されること' do
         click_on '作業項目一覧'
         task_list_content = all('.task_list_content')
         expect(task_list_content[0]).to have_content '4'
         expect(task_list_content[1]).to have_content '3'
      end
    end
  end

  describe 'バリデーションテスト１' do
    context 'Name欄を空のままタスクを作成しようとした場合' do
      it 'バリデーションエラー（空白制限）のメッセージが表示されること' do
        task = Task.new name: '', content: '河川敷クリーナーズ が 6 - 4 で勝ちました。'
        task.valid?
        expect(task.errors[:name]).to include('を入力してください')
      end
   end
  end

  describe 'バリデーションテスト３' do
    context 'Name欄に１００文字以上の入力をしてタスクを作成しようとした場合' do
      it 'バリデーションエラー（文字数制限）のメッセージが表示されること' do
        task = Task.new name: "#{'練習試合の結果' * 20}", content: '河川敷クリーナーズ が 6 - 4 で勝ちました。'
        task.valid?
        expect(task.errors[:name]).to include('は100文字以内で入力してください')
      end
    end
  end

  describe 'バリデーションテスト４' do
    context 'Content欄に１００文字以上の入力をしてタスクを作成しようとした場合' do
      it 'バリデーションエラー（文字数制限）のメッセージが表示されること' do
        task = Task.new name: "練習試合の結果", content: "#{'練習試合の結果' * 20}"
        task.valid?
        expect(task.errors[:content]).to include('は100文字以内で入力してください')
      end
    end
  end

  describe '作業項目の終了期限のテスト' do
    let(:user_a) { FactoryBot.create(:user)}
    context '：終了期限でソートするボタンを押した場合' do
      before do
        task_a = FactoryBot.create(:task, user_id: user_a.id)
        task_b = FactoryBot.create(:task2, user_id: user_a.id, created_at: Time.current + 1.days)
        task_c = FactoryBot.create(:task3, user_id: user_a.id, created_at: Time.current + 2.days)
        task_d = FactoryBot.create(:task4, user_id: user_a.id, created_at: Time.current + 3.days)
      end
      it 'バリデーションエラー（空白制限）のメッセージが表示されること' do
        visit root_path
        fill_in 'Email', with: user_a.email
        fill_in 'session_password', with: user_a.password
        fill_in 'session_password_conf', with: user_a.password
        click_on 'Log in'
        click_on "ichiran"
        click_link "kigen"
        expect(page).to have_content '作業一覧'
        task_list_content = all('tbody tr')
        expect(task_list_content[0]).to have_content 'Factoryで作った作業項目名4'
        expect(task_list_content[1]).to have_content 'Factoryで作った作業項目名3'
        expect(task_list_content[2]).to have_content 'Factoryで作った作業項目名2'
      end
    end
  end

  describe '作業優先度のテスト' do
    let(:user_a) { FactoryBot.create(:user)}
    context '優先度で並べ替えるボタンを押した場合' do
      before do
        task_a = FactoryBot.create(:task, id: 1, user: user_a)
        task_b = FactoryBot.create(:task2, id: 2, user: user_a, created_at: Time.current + 1.days)
        task_c = FactoryBot.create(:task3, id: 3, user: user_a, created_at: Time.current + 2.days)
        task_d = FactoryBot.create(:task4, id: 4, user: user_a, created_at: Time.current + 3.days)
      end
      it '作業項目が優先度の高い順に並んでいること' do
        visit root_path
        fill_in 'Email', with: user_a.email
        fill_in 'session_password', with: user_a.password
        fill_in 'session_password_conf', with: user_a.password
        click_on 'Log in'
        click_on "ichiran"
        click_on '高優先度で並べ替え'
        expect(page).to have_content '作業一覧'
        task_list = all('tbody tr')
        expect(task_list[0]).to have_content 'Factoryで作った作業項目名2'
        expect(task_list[1]).to have_content 'Factoryで作った作業項目名3'
        expect(task_list[2]).to have_content 'Factoryで作った作業項目名4'
        expect(task_list[3]).to have_content 'Factoryで作った作業項目名1'
      end
    end
  end

    describe '検索ロジックのモデルのテスト1：指定した項目名と状況で検索した場合' do
      let(:user_a) { FactoryBot.create(:user)}
        before do
          task_a = FactoryBot.create(:task, id: 1, user: user_a)
          task_b = FactoryBot.create(:task2, id: 2, user: user_a, created_at: Time.current + 1.days)
          task_c = FactoryBot.create(:task3, id: 3, user: user_a, created_at: Time.current + 2.days)
          task_d = FactoryBot.create(:task4, id: 4, user: user_a, created_at: Time.current + 3.days)
        end
          it '１つの作業項目だけが結果欄に残ること' do
            visit root_path
            fill_in 'Email', with: user_a.email
            fill_in 'session_password', with: user_a.password
            fill_in 'session_password_conf', with: user_a.password
            click_on 'Log in'
            # click_on "ichiran"
            visit tasks_path
            task_list = all('tbody tr')
            fill_in 'name', with: '4'
            select '着手中', from: 'status'
            click_on 'search'
            expect(page).to have_content 'Factoryで作った作業項目名4'
            expect(page).to_not have_content 'Factoryで作った作業項目名3'
          end
        end

    describe '検索ロジックのモデルのテスト2：入力欄を空のままで検索ボタンを押した場合' do
      let(:user_a) { FactoryBot.create(:user)}
        before do
          task_a = FactoryBot.create(:task, id: 1, user: user_a)
          task_b = FactoryBot.create(:task2, id: 2, user: user_a, created_at: Time.current + 1.days)
          task_c = FactoryBot.create(:task3, id: 3, user: user_a, created_at: Time.current + 2.days)
          task_d = FactoryBot.create(:task4, id: 4, user: user_a, created_at: Time.current + 3.days)
        end
          it 'インデックス画面が再表示されること' do
            visit root_path
            fill_in 'Email', with: user_a.email
            fill_in 'session_password', with: user_a.password
            fill_in 'session_password_conf', with: user_a.password
            click_on 'Log in'
            # click_on "ichiran"
            visit tasks_path
            task_list = all('tbody tr')
            click_on 'search'
            expect(page).to have_content 'Factoryで作った作業項目名1'
            expect(page).to have_content 'Factoryで作った作業項目名2'
            expect(page).to have_content 'Factoryで作った作業項目名3'
            expect(page).to have_content 'Factoryで作った作業項目名4'
          end
      end
  end
