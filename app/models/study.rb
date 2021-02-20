class Study < ApplicationRecord
	belongs_to :online
	belongs_to :question
	has_many :answer_images, dependent: :destroy
	has_many :correction_images, dependent: :destroy

	accepts_attachments_for :answer_images, attachment: :image
	accepts_attachments_for :correction_images, attachment: :image
end
