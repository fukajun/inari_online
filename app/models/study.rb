class Study < ApplicationRecord
	belongs_to :online
	belongs_to :question
	has_many :answer_images, dependent: :destroy

	accepts_attachments_for :answer_images, attachment: :image
end
