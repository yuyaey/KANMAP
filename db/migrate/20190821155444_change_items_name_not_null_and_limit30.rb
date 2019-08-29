class ChangeItemsNameNotNullAndLimit30 < ActiveRecord::Migration[5.2]
  def up
    change_column_null :items, :name, false
    change_column :items, :name, :string, limit: 30
  end

  def down
    change_column :items, :name, :string
  end
end
