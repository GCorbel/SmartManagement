class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name

      t.timestamps null: false
    end

    add_column :users, :company_id, :integer
    add_index :users, :company_id
  end
end
