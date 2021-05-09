class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
    	t.integer :online_id
    	t.integer :course
    	t.boolean :paid, default: false

      t.timestamps
    end
  end
end
