class MainController < ApplicationController
  def index
	@courses = Course.all
	if params[:term]
  		@courses = Course.search_by_course(params[:term])
  	end
  end
end
