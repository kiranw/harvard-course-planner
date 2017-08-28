class Course < ApplicationRecord
	include PgSearch
	pg_search_scope :search_by_course, against: [:title, :courseNumber],
	using: {
	  tsearch: {
	    prefix: true,
	    negation: true,
	    highlight: {
	        start_sel: '<b>',
	        stop_sel: '</b>',
		}
	  }
	}
end
