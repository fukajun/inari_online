class PaymentsController < ApplicationController
	def index
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
