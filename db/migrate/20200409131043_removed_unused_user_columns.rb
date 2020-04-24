class RemovedUnusedUserColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :password_digest, :string, { null: false }
    remove_index :users, column: :email
    # remove_column :users, :email, :string, { null: false }
  end
end
