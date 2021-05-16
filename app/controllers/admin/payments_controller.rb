class Admin::PaymentsController < ApplicationController
	def index
		@payments = Payment.all
	end

	def edit
		@payment = Payment.find(params[:id])
	end

	def update
		@payment = Payment.find(params[:id])
		@online = Online.find(@payment.online_id)
		if @payment.update(payment_params)

			# 振込確認後に学習教科開放
			if @payment.course == "数IA 1回目"
				if @payment.paid == true
					@online.math_iaf = true
				else
					@online.math_iaf = nil
				end
			elsif @payment.course == "数IA 2回目"
				if @payment.paid == true
					@online.math_ias = true
				else
					@online.math_ias = nil
				end
			elsif @payment.course == "数IIB 1回目"
				if @payment.paid == true
					@online.math_iibf = true
				else
					@online.math_iibf = nil
				end
			elsif @payment.course == "数IIB 2回目"
				if @payment.paid == true
					@online.math_iibs = true
				else
					@online.math_iibs = nil
				end
			elsif @payment.course == "数IIIC 1回目"
				if @payment.paid == true
					@online.math_iiicf = true
				else
					@online.math_iiicf = nil
				end
			elsif @payment.course == "数IIIC 2回目"
				if @payment.paid == true
					@online.math_iiics = true
				else
					@online.math_iiics = nil
				end
			end
			@online.update(online_params)

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
		params.permit(:math_iaf, :math_ias, :math_iibf, :math_iibs, :math_iiicf, :math_iiics)
	end
end
