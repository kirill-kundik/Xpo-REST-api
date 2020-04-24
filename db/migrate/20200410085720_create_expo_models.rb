class CreateExpoModels < ActiveRecord::Migration[5.2]
  def change
    create_table :expo_models do |t|
      t.string :ar_model_url, null: false
      t.string :marker_url, null: false
      t.references :expo, foreign_key: true, null: false

      t.timestamps
    end
  end
end
