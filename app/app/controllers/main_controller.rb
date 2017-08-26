class MainController < ApplicationController
  def index
  	@classes = Course.all
  end
end
