class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :memo
      t.string :image

      t.timestamps
    end
  end
end
