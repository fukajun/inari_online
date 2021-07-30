class NotificationHistory < ApplicationRecord
	belongs_to :online
	belongs_to :notification
end
