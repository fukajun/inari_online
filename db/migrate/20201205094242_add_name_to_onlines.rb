class AddNameToOnlines < ActiveRecord::Migration[5.2]
  def change
    add_column :onlines, :first_name, :string, null: false, default: ""
    add_column :onlines, :last_name, :string, null: false, default: ""
    add_column :onlines, :kana_name, :string, null: false, default: ""
    add_column :onlines, :parent_name, :string, null: false, default: ""
    add_column :onlines, :gender, :integer, null: false, default: 0
    add_column :onlines, :birthday, :date
    add_column :onlines, :high_school, :string
    add_column :onlines, :junior_high_school, :string
    add_column :onlines, :elementary_school, :string
    add_column :onlines, :grade, :integer, null: false, default: 0
    add_column :onlines, :postal_code, :string, null: false, default: ""
    add_column :onlines, :prefecture, :integer, null: false, default: 0
    add_column :onlines, :address, :string, null: false, default: ""
    add_column :onlines, :phone, :string, null: false, default: ""
    add_column :onlines, :parent_email, :string, null: false, default: ""
    add_column :onlines, :course, :integer, null: false, default: 0
    add_column :onlines, :math_iaf, :integer, default: 0
    add_column :onlines, :math_ias, :integer, default: 0
    add_column :onlines, :math_iibf, :integer, default: 0
    add_column :onlines, :math_iibs, :integer, default: 0
    add_column :onlines, :math_iiicf, :integer, default: 0
    add_column :onlines, :math_iiics, :integer, default: 0
    add_column :onlines, :membership_number, :integer
    add_column :onlines, :status, :boolean, null: false, default: true
    add_column :onlines, :note, :string
  end
end
