class StudiesController < ApplicationController
	before_action :authenticate_online!
	
	def index
		@studies = Study.where(online_id: current_online.id)

		# 単元テストスコア
		@iafScore = Array.new
		iafTotal = 0
		iafCount = 0
		@studies.each do |i|
			num = i.question.title.slice(14, 2).to_i
			if (num == 8 || num == 15 || num == 22)
				@iafScore.push(i.score.to_s + " 点")
				if i.score != nil
					iafCount += 1
					iafTotal += i.score
					@iafAverage = (iafTotal / iafCount).to_s + " 点"
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
