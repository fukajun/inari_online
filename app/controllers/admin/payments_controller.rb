class Admin::PaymentsController < ApplicationController
	def index
		@payments = Payment.all
	end

	def edit
		@payment = Payment.find(params[:id])
	end

	def update
		@payment = Payment.find(params[:id])
		if @payment.update(payment_params)
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
end
