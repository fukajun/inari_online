class Admin::PaymentsController < ApplicationController
	before_action :authenticate_admin!
	
	def index
		@q = Online.ransack(params[:q])
		@onlines = @q.result(distinct: true)
		if params[:unpaid]
			@payments = Payment.where(online_id: @onlines, paid: false).order(id: "DESC")
		else
			@payments = Payment.where(online_id: @onlines).order(id: "DESC")
		end
	end

	def edit
		@payment = Payment.find(params[:id])
	end

	def update
		@payment = Payment.find(params[:id])
		@online = Online.find(@payment.online_id)
		if @payment.update(payment_params)
			# 受講生番号採番
			if @online.membership_number == nil
				birthDay = @online.birthday.strftime("%Y%m%d").to_i
				baseDate = 20020402
				diffYear = (birthDay - baseDate) / 10000

				if diffYear < 0 # 2020年以前受講生
					numbering = Numbering.find(1)
				else
					numbering = Numbering.find(diffYear + 2)
				end
				number = numbering.final_number.floor(-2)
				newNumber = number + 100 + rand(100)
				numbering.update(final_number: newNumber)

				@online.membership_number = newNumber
			end

			# Subjectテーブルに教科登録
			@subject = Subject.new
			@subject.online_id = @online.id
			@subject.question = 1
			@subject.stage = 1

			# 振込確認後に学習教科開放
			if @payment.course == "数IA 1回目"
				if @payment.paid == true
					@online.math_iaf = 1
					@subject.course = 1
				else
					@online.math_iaf = nil
				end
			elsif @payment.course == "数IA 2回目"
				if @payment.paid == true
					@online.math_ias = 1
					@subject.course = 2
				else
					@online.math_ias = nil
				end
			elsif @payment.course == "数IIB 1回目"
				if @payment.paid == true
					@online.math_iibf = 1
					@subject.course = 3
				else
					@online.math_iibf = nil
				end
			elsif @payment.course == "数IIB 2回目"
				if @payment.paid == true
					@online.math_iibs = 1
					@subject.course = 4
				else
					@online.math_iibs = nil
				end
			elsif @payment.course == "数IIIC 1回目"
				if @payment.paid == true
					@online.math_iiicf = 1
					@subject.course = 5
				else
					@online.math_iiicf = nil
				end
			elsif @payment.course == "数IIIC 2回目"
				if @payment.paid == true
					@online.math_iiics = 1
					@subject.course = 6
				else
					@online.math_iiics = nil
				end
			elsif @payment.course == "数IA トライアル"
				if @payment.paid == true
					@online.math_iaf = 1
					@subject.course = 7
				else
					@online.math_iaf = nil
				end
			elsif @payment.course == "数IIB トライアル"
				if @payment.paid == true
					@online.math_iibf = 1
					@subject.course = 8
				else
					@online.math_iibf = nil
				end
			elsif @payment.course == "数IIIC トライアル"
				if @payment.paid == true
					@online.math_iiicf = 1
					@subject.course = 9
				else
					@online.math_iiicf = nil
				end
			end

			# Subjectテーブルに提出期限登録
			checkDate = Calendar.where(check: true)
			today = Time.current
			lessonArray = Array.new
			count = -2
			times = 1
			checkDate.each do |i|
				date = i.start_time.strftime("%Y-%m-%d %H:%M:%S")
				if today < i.start_time - (9 * 60 * 60)
					if count > 5
						lessonArray.push(date)
						lessonColumn = "lesson#{times}"
						@subject[lessonColumn] = date
						count = 0
						times += 1
						break if times > 22
					end
					count += 1
				end
			end
			
			@online.update(online_params)
			if @subject.course != nil
				@subject.save
			end

			@status = "success"
		else
			@status = "fail"
		end
			render 'update.js.erb'
	end

	def destroy
		@payment = Payment.find(params[:id])
		@payment.destroy
		redirect_to request.referer
	end

	private
	def payment_params
		params.require(:payment).permit(:course, :paid)
	end

	def online_params
		params.permit(:math_iaf, :math_ias, :math_iibf, :math_iibs, :math_iiicf, :math_iiics, :membership_number)
	end
end
