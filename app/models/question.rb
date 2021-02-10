class Question < ApplicationRecord
	has_many :studies, dependent: :destroy
end
