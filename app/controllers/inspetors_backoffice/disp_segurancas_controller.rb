class InspetorsBackoffice::DispSegurancasController < InspetorsBackofficeController
    def index
        @disp_segurancas = DispSeguranca.all
                                        .order(id: :desc)
                                        .page(params[:page])
                                        .per(50)

    end
end
