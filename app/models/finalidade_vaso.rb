class FinalidadeVaso < ApplicationRecord
    self.table_name = "finalidade_vasos"
    self.primary_key = "id"

    validates :finalidade, presence: true
end