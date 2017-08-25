class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.integer :courseId
      t.string :title
      t.string :courseNumber
      t.string :instructor
      t.text :description
      t.string :credits
      t.string :location
      t.string :hours
      t.string :days
      t.timestamps
    end
  end
end
