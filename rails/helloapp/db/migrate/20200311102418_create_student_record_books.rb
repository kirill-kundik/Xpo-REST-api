class CreateStudentRecordBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :student_record_books do |t|
      t.float :avg_grade, null: false, default: 0
      t.integer :student_id
      t.timestamps
    end
  end
end
