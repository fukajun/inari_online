class OnlinesController < ApplicationController
	before_action :authenticate_online!

	def top
		@online = current_online
		iaf = @online.math_iaf
		ias = @online.math_ias
		iibf = @online.math_iibf
		iibs = @online.math_iibs
		iiicf = @online.math_iiicf
		iiics = @online.math_iiics

		# 課題提出期限確認
		if iaf == 2
			@subject = Subject.find_by(online_id: current_online.id, course: 1)
		elsif ias == 2
			@subject = Subject.find_by(online_id: current_online.id, course: 2)
		elsif iibf == 2
			@subject = Subject.find_by(online_id: current_online.id, course: 3)
		elsif iibs == 2
			@subject = Subject.find_by(online_id: current_online.id, course: 4)
		elsif iiicf == 2
			@subject = Subject.find_by(online_id: current_online.id, course: 5)
		elsif iiics == 2
			@subject = Subject.find_by(online_id: current_online.id, course: 6)
		else
			@subject = Subject.find_by(online_id: current_online.id)
		end

		# 課題提出期限自動更新
		today = Time.current
		loopTime = 3 - @subject.postphonement

		# 期限超過による更新
		loopTime.times do
			lessonId = @subject.question

			if @subject.stage == 1
				deadLine = @subject["lesson#{lessonId}"]
			elsif @subject.stage == 3
				lessonId += 1
				deadLine = @subject["lesson#{lessonId}"]
			else
				deadLine = today + (24 * 60 * 60)
			end

			if (today > deadLine - (9 * 60 * 60))
				checkDate = Calendar.where(check: true)
				lessonArray = Array.new
				checkDate.each do |i|
					date = i.start_time.strftime("%Y-%m-%d %H:%M:%S")
					lessonArray.push(date)
				end

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
				loopTime -= 1
				@subject.update(subject_params)
			end
		end

		# 期限超過かつ延期回数満期によるステータス失効
		if (loopTime <= 0)
			lessonId = @subject.question
			if @subject.stage == 1
				deadLine = @subject["lesson#{lessonId}"]
			elsif @subject.stage == 3
				lessonId += 1
				deadLine = @subject["lesson#{lessonId}"]
			else
				deadLine = today + (24 * 60 * 60)
			end

			if (today > deadLine - (9 * 60 * 60))
				@online.update(status: "失効")
			end
		end

		@notification_histories = NotificationHistory.where(online_id: current_online.id).order(id: "DESC")

		# カレンダー表示
		@calendars = Calendar.all
	end
	
	def show
		@online = Online.find(params[:id])
		if @online.id != current_online.id
			redirect_to online_path(current_online.id)
		end
	end

	def edit
		@online = Online.find(params[:id])
		if @online.id != current_online.id
			redirect_to online_path(current_online.id)
		end
	end

	def update
		@online = Online.find(params[:id])
		if @online.update(online_params)
			redirect_to online_path(@online)
		else
			render "edit"
		end
	end

	private
	def online_params
		params.require(:online).permit(:first_name, :last_name, :kana_name, :parent_name, :gender, :birthday, :high_school, :junior_high_school, :elementary_school, :grade, :postal_code, :prefecture, :address, :phone, :parent_email)
	end

	def online_math_params
		params.permit(:math_iaf, :math_ias, :math_iibf, :math_iibs, :math_iiicf, :math_iiics)
	end

	def subject_params
		params.permit(:lesson1, :lesson2, :lesson3, :lesson4, :lesson5, :lesson6, :lesson7, :lesson8, :lesson9, :lesson10, :lesson11, :lesson12, :lesson13, :lesson14, :lesson15, :lesson16, :lesson17, :lesson18, :lesson19, :lesson20, :lesson21, :lesson22, :postphonement)
	end
end
