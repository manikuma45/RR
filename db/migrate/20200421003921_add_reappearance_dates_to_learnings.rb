# frozen_string_literal: true

class AddReappearanceDatesToLearnings < ActiveRecord::Migration[5.2]
  def change
    add_column :learnings, :reappearance_date, :date
  end
end
