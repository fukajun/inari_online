class Math::IaFirstController < ApplicationController
	def index
		@subject = Subject.find_by(online_id: current_online.id)
	end

	def test
		parameter = params[:id].to_i
		@question =Question.where("title like ?", "math_iaf_test_#{parameter}%").where.not("title like ?", "%_answer%").order(title: "ASC")
		@id = @question[0].title.delete!("math_iaf_test_")
	end

	def test_answer
		parameter = params[:id].to_i
		@question =Question.where("title like ?", "math_iaf_test_answer_#{parameter}%").order(title: "ASC")
		@id = @question[0].title.delete!("math_iaf_test_answer_")
	end

	def exercise
		parameter = params[:id].to_i
		@question =Question.where("title like ?", "math_iaf_exercise_#{parameter}%").where.not("title like ?", "%_answer%").order(title: "ASC")
		@id = @question[0].title.delete!("math_iaf_exercise_")
	end

	def exercise_answer
		parameter = params[:id].to_i
		@question =Question.where("title like ?", "math_iaf_exercise_answer_#{parameter}%").order(title: "ASC")
		@id = @question[0].title.delete!("math_iaf_exercise_answer_")
	end
end
