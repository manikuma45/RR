# README

# RR (Recurring Reminder)

## 概要
忘却曲線理論を参考にした、暗記学習を助けるメモとブックマークのサービスです。
覚えたい内容をメモする、あるいはウェブページをブックマークすると、それらが学習予定のアイテムとしてタイムライン上に並びます。
アイテムを読み終えてからチェックをつけると、忘却曲線に従った間隔の日数を経て、再びタイムライン上に同アイテムが現れます。
適切な間隔を置いて同じ項目を復習し続けることにより、ユーザーの暗記学習を支援します。

## 実装目標
* 作業予定の項目を登録できる
* 学習項目の作成・保存
* 学習項目一覧
* 学習項目の編集、削除
* ページネーション
* ログイン機能
* マイページ機能
* AWSデプロイ
* 学習項目の再出現機能
* 学習項目の消化機能
* 学習項目履歴
* 隠れた本文欄を見せるボタン

## 制作環境
* Ruby 2.6.5
* Ruby on Rails 5.2.4
* PostgreSQL 12.2

## 制作資料
* カタログ設計書
* テーブル定義書
* ER図
* 画面遷移図
https://drive.google.com/file/d/1c51cuMg9QzvegkNtJEpBPFIv8J5LnEw7/view?usp=sharing

# ワイヤーフレーム
https://drive.google.com/file/d/1TK8C1O7dDKvh28kFkPs1NLVLzxFgKgBU/view?usp=sharing


## 使用予定Gem
* devise
* ransack
* Bootstrap 3
* jquery-rails
* nginx
* unicorn
