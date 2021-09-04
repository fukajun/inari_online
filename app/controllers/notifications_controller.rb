class NotificationsController < ApplicationController
	before_action :authenticate_online!
	
  def show
  	@notification = Notification.find(params[:id])
  	@notification_histories = NotificationHistory.find_by(online_id: current_online.id, notification_id: params[:id])
  	if @notification_histories != nil
  		@notification_histories.update(checked: true)
  	else
			redirect_to onlines_top_path
		end
  end
end
