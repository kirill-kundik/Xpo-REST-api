class AddFacultyIdToStudent < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :faculty_id, :integer
  end
end
