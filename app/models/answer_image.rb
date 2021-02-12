class AnswerImage < ApplicationRecord
	belongs_to :study

	attachment :image
end
