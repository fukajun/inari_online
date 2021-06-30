class Admin::CalendarsController < ApplicationController
	def index
		@calendars = Calendar.all
	end

	def update
		@calendar = Calendar.find(params[:id])
		if params[:check] == "true"
			params[:check] = false
		else
			params[:check] = true
		end
		@calendar.update!(calendar_params)
		redirect_to request.referer
	end

	private
	def calendar_params
		params.permit(:title, :check)
	end
end
