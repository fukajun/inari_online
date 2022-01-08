class PaymentsController < ApplicationController
	before_action :authenticate_online!
	
	def index
		iaf = current_online.math_iaf
		ias = current_online.math_ias
		iibf = current_online.math_iibf
		iibs = current_online.math_iibs
		iiicf = current_online.math_iiicf
		iiics = current_online.math_iiics
		num = iaf + ias + iibf + iibs + iiicf + iiics
		deadLineDisp = false
		if num < 2
			deadLineDisp = true
		end

		# 受講申請可否配列
		subjects = Array.new(6)
		unpaid = Payment.find_by(online_id: current_online, paid: 0)
		if unpaid == nil
			for i in 0..5
				num = 6 - i
				subject = Subject.find_by(online_id: current_online, course: num)
				if (subject != nil)
					if (subject.question >= 16)
						subjects[num] = true
						subjects[num + 1] = (num % 2) == 1? true : nil
					end
					break;
				end
			end
		end

		# 支払い一覧表示内容配列
		@payments = Array.new(6).map{Array.new(3, "")}
		6.times do |i|
			@payment = Payment.find_by(online_id: current_online, course: i + 1)
			@payments[i][0] = Payment.courses.key(i+1)
			if @payment != nil
				@payments[i][1] = @payment.created_at.strftime("%Y年%m月%d日")
				if @payment.paid == true
					@payments[i][2] = "振込済"
				elsif deadLineDisp
					deadLine = @payment.created_at  + 14.days
					@payments[i][2] = deadLine.strftime("%Y年%m月%d日")
				else
					@payments[i][2] = "-"
				end
			else
				@payments[i][1] = subjects[i]
			end
		end
	end

	def create
		@payment = Payment.new
		@payment.online_id = current_online.id
		@payment.course = params[:course]

		if (@payment.course == "数IA 1回目")
			current_online.update(math_iaf: 1)
		elsif (@payment.course == "数IA 2回目")
			current_online.update(math_ias: 1)
		elsif (@payment.course == "数IIB 1回目")
			current_online.update(math_iibf: 1)
		elsif (@payment.course == "数IIB 2回目")
			current_online.update(math_iibs: 1)
		elsif (@payment.course == "数IIIC 1回目")
			current_online.update(math_iiicf: 1)
		elsif (@payment.course == "数IIIC 2回目")
			current_online.update(math_iiics: 1)
		end
		@payment.save
		redirect_to request.referer
		RegistrationMailer.course_application(current_online, @payment).deliver
	end
end
