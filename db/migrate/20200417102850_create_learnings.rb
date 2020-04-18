class CreateLearnings < ActiveRecord::Migration[5.2]
  def change
    create_table :learnings do |t|
      t.string :title
      t.text :main_content
      t.text :sub_content
      t.string :url_info
      t.date :checked_on
      t.integer :checked_times
      t.string :image

      t.timestamps
    end
  end
end
