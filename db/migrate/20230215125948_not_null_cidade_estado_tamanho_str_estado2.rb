class NotNullCidadeEstadoTamanhoStrEstado2 < ActiveRecord::Migration[5.2]
  def change
    change_column_null :CIDADES, :Cidade, false
    change_column_null :CIDADES, :EstadoOuProvincia, false
    #change_column :CIDADES, :EstadoOuProvincia, :string, limit: 2
    #Não foi possível mudar pois existe uma view vw_cidade_x_estado_id que depende deste campo
  end
end