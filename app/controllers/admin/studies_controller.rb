class Admin::StudiesController < ApplicationController
	def index
		@studies = Study.all.reverse_order
  end

	def show
		@study = Study.find(params[:id])
		@answer_images = AnswerImage.where(study_id: @study.id)
	end

	def edit
		@study = Study.find(params[:id])
	end
end
