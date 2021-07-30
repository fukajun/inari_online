class CreateNotificationHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :notification_histories do |t|
    	t.integer :online_id
    	t.integer :notification_id
    	t.boolean :checked, default: false

      t.timestamps
    end
  end
end
