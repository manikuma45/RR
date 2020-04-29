# frozen_string_literal: true

class RenameCreatedAtColumnToCreatedOn < ActiveRecord::Migration[5.2]
  def change
    rename_column :learnings, :created_at, :created_on
  end
end
