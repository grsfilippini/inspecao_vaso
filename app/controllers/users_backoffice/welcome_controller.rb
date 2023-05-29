class UsersBackoffice::WelcomeController < UsersBackofficeController
    def index
        # Cadastro
        #@num_clientes = UserEstatistica.find_or_create_by(user: current_user, evento: UserEstatistica::EVENTOS[:total_cliente]).valor
        #@num_fabricantes = UserEstatistica.find_or_create_by(user: current_user, evento: UserEstatistica::EVENTOS[:total_fabricante]).valor
        
        @num_clientes = Cadastro.where(eh_fabricante: false, eh_empresa_inspetora: false, user_id: current_user.id).count
        @num_fabricantes = Cadastro.where(eh_fabricante: true, user_id: current_user.id).count
        @num_vasos = Vaso.where(user_id: current_user.id).count;
        @num_disp_seg = DispSeguranca.where(user_id: current_user.id).count;
        @num_corps = Corp.where(user_id: current_user.id).count;
        @num_instrumentos_padrao = InstrumentoPadrao.where(user_id: current_user.id).count;
        @num_phs = Ph.where(user_id: current_user.id).count;
        
        # Emissão
        @num_rel_insp_inicial = Relatorio.where(user_id: current_user.id).where(tipo_inspecao_id: 2).count;
        @num_rel_insp_periodica = Relatorio.where(user_id: current_user.id).where(tipo_inspecao_id: 0).count;
        @num_rel_insp_outras = Relatorio.where(user_id: current_user.id).where.not(tipo_inspecao_id: [0, 2]).count;
        @num_rel_esp_vaso = EspessuraVaso.where(user_id: current_user.id).count;
        @num_rel_disp_seg = RelatorioDispseg.where(user_id: current_user.id).count;
        @num_cert_cal_disp_seg = RelatorioDispseg.where(user_id: current_user.id).where(bfoi_calibrada: true).count;
        @num_arts = Art.where(user_id: current_user.id).count;
        
    end    
end
