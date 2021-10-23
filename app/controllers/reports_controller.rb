class ReportsController < ApplicationController
	before_action :authenticate_parent!

	def index
		@studies = Study.where(online_id: current_parent.id)

		# 単元テストスコア
		@iafScore = Array.new
		iafTotal = 0
		iafCount = 0
		@studies.each do |i|
			num = i.question.title.slice(14, 2).to_i
			if (num == 8 || num == 15 || num == 22)
				@iafScore.push(i.score)
				if i.score != nil
					iafCount += 1
					iafTotal += i.score
					@iafAverage = iafTotal / iafCount
				end
			end
		end
	end

	private
	def authenticate_parent!
		redirect_to new_parent_session_path unless parent_signed_in?
	end
end
