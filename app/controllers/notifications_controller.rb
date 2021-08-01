class NotificationsController < ApplicationController
  def show
  	@notification = Notification.find(params[:id])
  	@notification_histories = NotificationHistory.find_by(online_id: current_online.id, notification_id: params[:id])
  	@notification_histories.update(checked: true)
  end
end
