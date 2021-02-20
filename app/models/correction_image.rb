class CorrectionImage < ApplicationRecord
	belongs_to :study

	attachment :image
end
