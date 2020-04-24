class CreateExpos < ActiveRecord::Migration[5.2]
  def change
    create_table :expos do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :image_url, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.string :location_name, null: false
      t.integer :views_count, null: false, default: 0
      t.integer :likes_count, null: false, default: 0
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
