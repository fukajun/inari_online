class StudiesController < ApplicationController
	def index
		@studies = Study.where(online_id: current_online.id)
	end

	def show
		@study = Study.find(params[:id])
		@correction_images = CorrectionImage.where(study_id: @study.id)
	end
end
