class StudiesController < ApplicationController
	before_action :authenticate_online!
	
	def index
		@studies = Study.where(online_id: current_online.id)
	end

	def show
		@study = Study.find_by(online_id: current_online.id, id: params[:id])
		if @study != nil
			@correction_images = CorrectionImage.where(study_id: @study.id)
  	else
			redirect_to studies_path
		end
	end
end
