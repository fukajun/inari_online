class CreateSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :subjects do |t|
      t.integer :online_id
      t.integer :course
      t.integer :question
      t.integer :stage
      t.datetime :lesson1
      t.datetime :lesson2
      t.datetime :lesson3
      t.datetime :lesson4
      t.datetime :lesson5
      t.datetime :lesson6
      t.datetime :lesson7
      t.datetime :lesson8
      t.datetime :lesson9
      t.datetime :lesson10
      t.datetime :lesson11
      t.datetime :lesson12
      t.datetime :lesson13
      t.datetime :lesson14
      t.datetime :lesson15
      t.datetime :lesson16
      t.datetime :lesson17
      t.datetime :lesson18
      t.datetime :lesson19
      t.datetime :lesson20
      t.datetime :lesson21
      t.datetime :lesson22
      t.integer :postphonement

      t.timestamps
    end
  end
end
