class Notification < ApplicationRecord
	has_many :notification_histories, dependent: :destroy
end
