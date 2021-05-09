class Payment < ApplicationRecord
	belongs_to :online

	enum course: {"数IA 1回目": 1, "数IA 2回目": 2, "数IIB 1回目": 3, "数IIB 2回目": 4, "数IIIC 1回目": 5, "数IIIC 2回目": 6, "数IA トライアル": 7, "数IIB トライアル": 8, "数IIIC トライアル": 9}
end
