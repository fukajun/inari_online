class AddNameToOnlines < ActiveRecord::Migration[5.2]
  def change
    add_column :onlines, :first_name, :string
    add_column :onlines, :last_name, :string
    add_column :onlines, :kana_name, :string
    add_column :onlines, :parent_name, :string
    add_column :onlines, :gender, :integer
    add_column :onlines, :birthday, :date
    add_column :onlines, :school, :string
    add_column :onlines, :grade, :integer
    add_column :onlines, :prefecture, :integer
    add_column :onlines, :address, :text
    add_column :onlines, :phone, :string
    add_column :onlines, :parent_email, :string
    add_column :onlines, :subject, :integer
    add_column :onlines, :membership_number, :integer
    add_column :onlines, :status, :boolean, null: false, default: true
  end
end
