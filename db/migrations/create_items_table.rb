class CreateItemsTableMigration < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name
      t.date :due_date
      t.integer :lists_id
      t.timestamps
    end
  end
end
