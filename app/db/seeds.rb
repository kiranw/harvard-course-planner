require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'courses.csv'))
csv = CSV.parse(csv_text, headers:true, encoding:'iso-8859-1:utf-8')
csv.each do |row|
  c = Course.new
  c.courseId = row[0]
  c.title = row[1]
  c.courseNumber = row[2]
  c.instructor = row[3]
  c.description = row[4]
  c.credits = row[4]
  c.location = row[5]
  c.days = row[6]
  c.hours = row[7]
  c.save
  puts c.title
end

puts "There are now #{course.count} rows in the courses table"