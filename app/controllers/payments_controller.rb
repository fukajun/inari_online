class PaymentsController < ApplicationController
	def index
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
				else
					deadLine = @payment.created_at  + 14.days
					@payments[i][2] = deadLine.strftime("%Y年%m月%d日")
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
		@payment.save
		redirect_to request.referer
	end
end
