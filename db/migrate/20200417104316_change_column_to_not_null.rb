# frozen_string_literal: true

class ChangeColumnToNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :learnings, :title, null: false
    change_column_null :learnings, :checked_on, null: false
    change_column_null :learnings, :checked_times, null: false
  end
end
