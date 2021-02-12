class CreateAnswerImages < ActiveRecord::Migration[5.2]
  def change
    create_table :answer_images do |t|
    	t.integer :study_id
      t.string :image_id

      t.timestamps
    end
  end
end
