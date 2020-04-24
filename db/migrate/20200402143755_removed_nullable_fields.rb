class RemovedNullableFields < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :login, false
    change_column_null :users, :password_digest, false
    change_column_null :users, :name, false
  end
end
