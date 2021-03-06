# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_200_421_005_957) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'labelings', force: :cascade do |t|
    t.bigint 'learning_id'
    t.bigint 'label_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['label_id'], name: 'index_labelings_on_label_id'
    t.index ['learning_id'], name: 'index_labelings_on_learning_id'
  end

  create_table 'labels', force: :cascade do |t|
    t.string 'label_name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'learnings', force: :cascade do |t|
    t.text 'title'
    t.text 'main_content'
    t.text 'sub_content'
    t.text 'url_info'
    t.date 'checked_on'
    t.integer 'checked_times'
    t.text 'image'
    t.datetime 'created_on', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'user_id'
    t.date 'reappearance_date'
    t.index ['user_id'], name: 'index_learnings_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'name'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'labelings', 'labels'
  add_foreign_key 'labelings', 'learnings'
  add_foreign_key 'learnings', 'users'
end
