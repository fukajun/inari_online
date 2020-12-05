class AddNameToStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :first_name, :string
    add_column :students, :last_name, :string
    add_column :students, :kana_name, :string
    add_column :students, :parent_name, :string
    add_column :students, :gender, :integer
    add_column :students, :birthday, :date
    add_column :students, :school, :string
    add_column :students, :grade, :integer
    add_column :students, :prefecture, :integer
    add_column :students, :address, :text
    add_column :students, :phone, :string
    add_column :students, :parent_email, :string
    add_column :students, :subject, :integer
    add_column :students, :membership_number, :integer
    add_column :students, :status, :boolean, null: false, default: true
  end
end
