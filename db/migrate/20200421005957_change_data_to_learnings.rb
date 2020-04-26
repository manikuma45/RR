class ChangeDataToLearnings < ActiveRecord::Migration[5.2]
  def change
    change_column :learnings, :title, :text
    change_column :learnings, :url_info, :text
  end
end
