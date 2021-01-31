class CreateSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :subjects do |t|
      t.integer :online_id
      t.boolean :math_iaf, null: false, default: false
      t.integer :question_iaf
      t.integer :stage_iaf
      t.boolean :math_ias, null: false, default: false
      t.integer :question_ias
      t.integer :stage_ias
      t.boolean :math_iibf, null: false, default: false
      t.integer :question_iibf
      t.integer :stage_iibf
      t.boolean :math_iibs, null: false, default: false
      t.integer :question_iibs
      t.integer :stage_iibs
      t.boolean :math_iiicf, null: false, default: false
      t.integer :question_iiicf
      t.integer :stage_iiicf
      t.boolean :math_iiics, null: false, default: false
      t.integer :question_iiics
      t.integer :stage_iiics

      t.timestamps
    end
  end
end
