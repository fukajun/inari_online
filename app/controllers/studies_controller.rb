class StudiesController < ApplicationController
	def index
		@studies = Study.where(online_id: current_online.id)
	end
end
