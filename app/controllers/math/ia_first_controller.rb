class Math::IaFirstController < ApplicationController
	def index
		@subject = Subject.find_by(online_id: current_online.id)
	end

	def test
	end

	def test_answer
	end

	def exercise
	end

	def exercise_answer
	end
end
