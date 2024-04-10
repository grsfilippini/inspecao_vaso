class InspetorsBackoffice::RelatorioDispsegsController < InspetorsBackofficeController

    def pesquisa

        params[:num_serie]
        
        @relatorio_dispsegs = RelatorioDispseg.joins(:vaso)
                              .where("LOWER(vasos.num_serie) LIKE LOWER(?)", "%#{params[:num_serie_vaso]}%")
                              .order(id: :desc)
                              .page(params[:page])
                              .per(50)


    end

end
