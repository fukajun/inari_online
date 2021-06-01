class Subject < ApplicationRecord
	belongs_to :online

	validates :online_id, uniqueness: {scope: [:course]}
end
