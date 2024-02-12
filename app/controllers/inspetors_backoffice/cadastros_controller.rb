class InspetorsBackoffice::CadastrosController < InspetorsBackofficeController

    def json_data      
        @cadastro = Cadastro.find(params[:id])
        render json: { cidade_id: @cadastro.cidade_id }
      end

    private
    
end
