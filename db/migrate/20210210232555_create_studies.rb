class CreateStudies < ActiveRecord::Migration[5.2]
  def change
    create_table :studies do |t|
      t.integer :online_id
      t.integer :question_id
      t.integer :answer_time
      t.integer :score

      t.timestamps
    end
  end
end
