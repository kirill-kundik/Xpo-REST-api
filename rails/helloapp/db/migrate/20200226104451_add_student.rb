class AddStudent < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.string :name, limit: 100, null: false, default: ''
      t.integer :age
    end
  end
end
