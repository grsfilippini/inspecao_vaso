class FinalidadeDoVaso < ApplicationRecord
    self.table_name = "FINALIDADE_DO_VASO"
    self.primary_key = "id"

    validates :finalidade_do_vaso, presence: true
end