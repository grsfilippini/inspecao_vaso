class Cadastro < ApplicationRecord
  belongs_to :corp
  belongs_to :cidade
  belongs_to :regiao
end
