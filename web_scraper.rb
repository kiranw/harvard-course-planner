require 'HTTParty'
require 'Nokogiri'
require 'JSON'
require 'Pry'
require 'csv'
require 'date'


# initialization
url_start = 'https://courses.harvard.edu/search?fq_coordinated_semester_yr=coordinated_semester_yr%3A%22Sep+to+Dec+2017+%28Fall+Term%29%22&fq_school_nm=&q=&sort=course_title+asc&start='
url_end = '&submit=Search'
page_number = 1
another_page = true
class_array = []
objects_per_page = 25

# generate page url by specifying which object# to start at, instead of page number
page = HTTParty.get(url_start + (page_number * objects_per_page).to_s + url_end)

# parse the page and scrape for data
while another_page == true
	parse_page = Nokogiri::HTML(page)
	parse_page.css('tbody').css('tr').css('.course').map do |c|
		courseId = c.attribute('id').value.split('_')[2]
		# expandable content, moreInfo
		moreInfo = parse_page.css('tbody').css('tr').css("#moredetailstr-" + courseId).css("p").map{|a| a.text.split(':')[1].strip()}
		title = c.css("#srl_title").text
		courseNumber = c.css(".course_title").text.split('-')[0]
		instructor = c.css("#srl_instructor").text
		description = "n/a"
		credits = "TBD"
		location = "TBD"
		if moreInfo.length > 0
			description = moreInfo[0].length > 3 ? moreInfo[0] : ""
			credits = moreInfo[0].length > 3 ? moreInfo[1] : moreInfo[0]
			location = moreInfo[2]
		end
		days = c.css(".meet").children.map{|d| d.attribute('title').value }
		hoursRough = c.css(".time").text.split('-').map{|time| time.strip() }
		hours = hoursRough.length ==2 ? hoursRough : []
		complete_course = [courseId, title, courseNumber, instructor, description, credits, location, days, hours]
		class_array.push(complete_course)
	end

	if parse_page.css('.pagenavigation').children[-1].attribute('class').value == 'prevnext'
		page_number += 1 
		page_Url = url_start + (page_number * objects_per_page).to_s + url_end
		page = HTTParty.get(page_Url)
	else
		another_page = false
	end
end

# write to csv
CSV.open('courses.csv', 'w') do |csv|
	class_array.each do |c|
		csv << c
	end
end