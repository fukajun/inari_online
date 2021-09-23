class AdminsController < ApplicationController
	before_action :authenticate_admin!
	
	def top
		@calendars = Calendar.all
	end
end
