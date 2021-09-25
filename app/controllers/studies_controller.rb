class StudiesController < ApplicationController
	before_action :authenticate_online!
	
	def index
		@studies = Study.where(online_id: current_online.id)

		# 単元テストスコア
		@iafScore = Array.new
		iafTotal = 0
		iafCount = 0
		@studies.each do |i|
			num = i.question_id
			if (num == 8 || num == 15 || num == 22)
				@iafScore.push(@studies.find_by(question_id: num).score)
				if @studies.find_by(question_id: num).score != nil
					iafCount += 1
					iafTotal += @studies.find_by(question_id: num).score
					@iafAverage = iafTotal / iafCount
				end
			end
		end
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
