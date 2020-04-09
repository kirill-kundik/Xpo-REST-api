class CreateExpos < ActiveRecord::Migration[5.2]
  def change
    create_table :expos do |t|
      t.string :name
      t.text :description
      t.string :image_url
      t.datetime :start_time
      t.datetime :end_time
      t.string :location_name

      t.timestamps
    end
  end
end
