# frozen_string_literal: true

class ChangeDataImageToLearning < ActiveRecord::Migration[5.2]
  def change
    change_column :learnings, :image, :text
  end
end
