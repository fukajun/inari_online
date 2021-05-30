class CreateNumberings < ActiveRecord::Migration[5.2]
  def change
    create_table :numberings do |t|
      t.integer :final_number

      t.timestamps
    end
  end
end
