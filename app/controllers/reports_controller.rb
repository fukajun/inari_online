class ReportsController < ApplicationController
	before_action :authenticate_parent!

	def index
		@studies = Study.where(online_id: current_parent.id)
	end

	private
	def authenticate_parent!
		redirect_to new_parent_session_path unless parent_signed_in?
	end
end
