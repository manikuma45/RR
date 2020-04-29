# frozen_string_literal: true

class AddReferencesToLearnings < ActiveRecord::Migration[5.2]
  def change
    add_reference :learnings, :user, foreign_key: true
  end
end
