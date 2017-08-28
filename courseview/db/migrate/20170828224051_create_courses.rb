class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :courseId
      t.string :title
      t.string :courseNumber
      t.string :instructor
      t.string :description
      t.integer :credits
      t.string :location
      t.string :days
      t.string :hours

      t.timestamps
    end
  end
end
