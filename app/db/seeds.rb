# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'courses.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  c = Courses.new
  c.courseId = row['courseId']
  c.title = row['title']
  c.courseNumber = row['courseNumber']
  c.instructor = row['instructor']
  c.description = row['description']
  c.credits = row['credits']
  c.location = row['location']
  c.days = row['days']
  c.hours = row['hours']
  c.save
  puts "#{c.title}, #{c.courseNumber} saved"
end

puts "There are now #{Courses.count} rows in the transactions table"
