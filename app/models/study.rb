class Study < ApplicationRecord
	belongs_to :online
	belongs_to :question

	attachment :answer
	attachment :correction
end
