class CreateKanzumes < ActiveRecord::Migration[5.2]
  def change
    create_table :kanzumes do |t|
      t.string :name, limit: 30, null: false
      t.bigint "user_id", null: false
      t.index ["user_id"], name: "index_kazumes_on_user_id"
      t.timestamps
    end
  end
end
