class Subject < ApplicationRecord
	belongs_to :online

	validates :online_id, uniqueness: {scope: [:course]}

	enum course: {"数IA 1回目": 1, "数IA 2回目": 2, "数IIB 1回目": 3, "数IIB 2回目": 4, "数IIIC 1回目": 5, "数IIIC 2回目": 6, "演習1 1回目(前半)": 7, "演習1 1回目(後半)": 8, "演習1 2回目(前半)": 9, "演習1 2回目(後半)": 10, "演習2(前半)": 11, "演習2(後半)": 12, "演習数III(前半)": 13, "演習数III(後半)": 14}
end
