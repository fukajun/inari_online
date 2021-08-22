class Admin::StudiesController < ApplicationController
	def index
		@q = Online.ransack(params[:q])
		@onlines = @q.result(distinct: true)
		@studies = Study.where(online_id: @onlines).reverse_order
  end

	def show
		@study = Study.find(params[:id])
		@answer_images = AnswerImage.where(study_id: @study.id)
		@correction_images = CorrectionImage.where(study_id: @study.id)
	end

	def edit
		@study = Study.find(params[:id])
	end

	def update
		@study = Study.find(params[:id])
		@study.update(study_params)
		redirect_to admin_study_path(@study)
	end

	def destroy
		@study = Study.find(params[:id])
		@correction_image = CorrectionImage.where(study_id: @study.id)
		@correction_image.delete_all
		redirect_to admin_study_path(@study)
	end

	private
	def study_params
		params.require(:study).permit(:score, correction_images_images: [])
	end
end
