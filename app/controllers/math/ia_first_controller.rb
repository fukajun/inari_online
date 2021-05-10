class Math::IaFirstController < ApplicationController
	def index
		@subject = Subject.find_by(online_id: current_online.id, course: 1)
	end

	def test
		@parameter = params[:id].to_i
		@number = "%02d" % params[:id]
		@question = Question.where("title like ?", "math_iaf_test_#{@number}%").where.not("title like ?", "%_answer%").order(title: "ASC")

		@id = Array.new
		@question.each do |i|
			num = i.title.delete!("math_iaf_test_").delete!(".png")
			@id.push(num)
		end

		@study = Study.new(question_id: @parameter)
	end

	def test_answer
		@number = "%02d" % params[:id]
		@question = Question.where("title like ?", "math_iaf_test_answer_#{@number}%").order(title: "ASC")

		@id = Array.new
		@question.each do |i|
			num = i.title.delete!("math_iaf_test_answer_").delete!(".png")
			@id.push(num)
		end
	end

	def exercise
		number = "%02d" % params[:id]
		@question = Question.where("title like ?", "math_iaf_exercise_#{number}%").where.not("title like ?", "%_answer%").order(title: "ASC")

		@id = Array.new
		@question.each do |i|
			num = i.title.delete!("math_iaf_exercise_").delete!(".png")
			@id.push(num)
		end
	end

	def exercise_answer
		number = "%02d" % params[:id]
		@question = Question.where("title like ?", "math_iaf_exercise_answer_#{number}%").order(title: "ASC")

		@id = Array.new
		@question.each do |i|
			num = i.title.delete!("math_iaf_exercise_answer_").delete!(".png")
			@id.push(num)
		end
	end

	def create
		@study = Study.new(study_params)
		@study.online_id = current_online.id
		@study.question_id = params[:study][:question_id]
		if @study.save
			@subject = Subject.find_by(online_id: current_online.id, course: 1)
			# 単元テストの条件分岐
			if @subject.question == params[:study][:params].to_i
				if @subject.question.in?([8, 15, 22])
					@subject.update(question: @subject.question + 1)
				else
					@subject.update(stage: 3)
				end
			end
			redirect_to math_ia_first_test_answer_path(params[:study][:params])
		end
	end

	def update
		@subject = Subject.find_by(online_id: current_online.id)
		if @subject.question == params[:id].to_i
			@subject.update(question: @subject.question + 1, stage: 1)
		end		
		redirect_to math_ia_first_exercise_answer_path
	end

	private
	def study_params
		params.require(:study).permit(answer_images_images: [])
	end
end
