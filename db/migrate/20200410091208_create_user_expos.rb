class CreateUserExpos < ActiveRecord::Migration[5.2]
  def change
    create_table :user_expos do |t|
      t.references :user, foreign_key: true, null: false
      t.references :expo, foreign_key: true, null: false
      t.boolean :liked, null: false, default: false

      t.timestamps
    end
  end
end
