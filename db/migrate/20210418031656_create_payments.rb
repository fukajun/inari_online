class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
    	t.integer :online_id
    	t.integer :month
    	t.integer :status

      t.timestamps
    end
  end
end
