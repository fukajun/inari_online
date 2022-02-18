class Admin::NotificationsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @notifications = Notification.all.order(id: "DESC").page(params[:page])
  end

  def new
    @notification = Notification.new
    @courses = Online.courses.keys

    @q = Online.ransack(params[:q])
    @onlines = @q.result(distinct: true)
  end

  def create
    @notification = Notification.new(notification_params)
    if @notification.save
      onlineArray = params[:notification][:onlineList].split(",")
      for num in onlineArray do
        @notification_history = NotificationHistory.new
        @notification_history.online_id = num
        @notification_history.notification_id = @notification.id
        @notification_history.save
      end
      redirect_to admin_notifications_path
    else
      render :new
    end
  end

  def show
    @notification_histories = NotificationHistory.where(notification_id: params[:id])
    @notification = Notification.find(params[:id])
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    redirect_to request.referer
  end

  private
  def notification_params
    params.require(:notification).permit(:title, :body)
  end
end
