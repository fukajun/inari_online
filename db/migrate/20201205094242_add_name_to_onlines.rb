class AddNameToOnlines < ActiveRecord::Migration[5.2]
  def change
    add_column :onlines, :first_name, :string
    add_column :onlines, :last_name, :string
    add_column :onlines, :kana_name, :string
    add_column :onlines, :parent_name, :string
    add_column :onlines, :gender, :integer
    add_column :onlines, :birthday, :date
    add_column :onlines, :school, :string
    add_column :onlines, :grade, :integer, default: 0
    add_column :onlines, :postal_code, :integer
    add_column :onlines, :prefecture, :integer, default: 0
    add_column :onlines, :address, :text
    add_column :onlines, :phone, :string
    add_column :onlines, :parent_email, :string
    add_column :onlines, :course, :integer
    add_column :onlines, :math_iaf, :boolean
    add_column :onlines, :math_ias, :boolean
    add_column :onlines, :math_iibf, :boolean
    add_column :onlines, :math_iibs, :boolean
    add_column :onlines, :math_iiicf, :boolean
    add_column :onlines, :math_iiics, :boolean
    add_column :onlines, :membership_number, :integer
    add_column :onlines, :status, :boolean, null: false, default: true
  end
end
