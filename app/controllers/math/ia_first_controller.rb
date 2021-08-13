class Math::IaFirstController < ApplicationController
	def index
		@subject = Subject.find_by(online_id: current_online.id, course: 1)
	end

	def postphone
		@subject = Subject.find_by(online_id: current_online.id, course: 1)

		# 課題提出期限延長
		if @subject.postphonement < 3
			checkDate = Calendar.where(check: true)
			lessonArray = Array.new
			checkDate.each do |i|
				date = i.start_time.strftime("%Y-%m-%d %H:%M:%S")
				lessonArray.push(date)
			end

			lessonId = @subject.question
			lessonArray.each do |j|
		 		lessonColumn = "lesson#{lessonId}"
		 		if (@subject[lessonColumn].strftime("%Y-%m-%d %H:%M:%S") == j)
		 			index = lessonArray.index(j)
		 			@subject[lessonColumn] = lessonArray[index + 6]
					lessonId += 1
					break if lessonId > 22
				end
			end
			@subject.postphonement += 1
			@subject.update(subject_params)
		end

		redirect_to request.referer
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

		@study = Study.find_by(online_id: current_online.id, question_id: @parameter)
		if @study == nil
			@study = Study.new
			@study.online_id = current_online.id
			@study.question_id = @parameter
			@study.save
			# 受講申請案内
			if @study.question_id == 16
				@notification = Notification.new
				@notification.title = "次の講座のご案内"
				@notification.body = "次の講座の受講申請が可能です。"
				if @notification.save
					@notification_history = NotificationHistory.new
					@notification_history.online_id = current_online.id
					@notification_history.notification_id = @notification.id
					@notification_history.save
				end
			end
		end

		@timeArray = [@study.created_at, @study.answer_time]
	end

	def test_answer
		@parameter = params[:id].to_i
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

	def update
		@subject = Subject.find_by(online_id: current_online.id, course: 1)
		@study = Study.find_by(online_id: current_online.id, question_id: params[:id])

		if params[:commit] != nil
			# 採点後回答再提出不可
			if @study.score == nil
				# 初回のみ回答時間登録
				if @study.answer_time == nil
					currentTime = Time.now;
					startTime = @study.created_at
					answerTime = currentTime - startTime
					@study.answer_time = answerTime
				end
				@study.update(study_params)

				# 単元テストの条件分岐
				if @subject.question == params[:id].to_i
					if @subject.question.in?([8, 15, 22])
						@subject.update(question: @subject.question + 1)
					else
						@subject.update(stage: 3)
					end
				end
				# 単元修了処理
				@online = current_online
				if @subject.question == 23
					@online.update(math_iaf: 3)
					@subject.update(stage: 0)
				end
			end
			redirect_to math_ia_first_test_answer_path(params[:id])
		else
			if @subject.question == params[:id].to_i
				@subject.update(question: @subject.question + 1, stage: 1)
			end
			redirect_to math_ia_first_exercise_answer_path(params[:id])
		end
	end

	private
	def study_params
		params.require(:study).permit(answer_images_images: [])
	end

	def subject_params
		params.permit(:lesson1, :lesson2, :lesson3, :lesson4, :lesson5, :lesson6, :lesson7, :lesson8, :lesson9, :lesson10, :lesson11, :lesson12, :lesson13, :lesson14, :lesson15, :lesson16, :lesson17, :lesson18, :lesson19, :lesson20, :lesson21, :lesson22, :postphonement)
	end
end
