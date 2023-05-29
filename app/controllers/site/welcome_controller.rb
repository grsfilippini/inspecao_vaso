class Site::WelcomeController < SiteController
  def index       
      # O includes abaixo inclui na query a busca por cadastro_corp
      # Se não for usado, e usar diretamente na view da index, ele fará a cada cadastro uma nova query para buscar a corporação
      if !current_user.nil?
        @vasos = Vaso.ultimos_vasos(params[:page], current_user.id)
        @count_vasos = Vaso.ultimos_vasos_sem_pagina(current_user.id).count
        
        @fabricantes = Cadastro.where(eh_fabricante: true, eh_empresa_inspetora: false, user_id: current_user.id).order(:nome_curto)
        @proprietarias = Cadastro.where(eh_fabricante: false, eh_empresa_inspetora: false, user_id: current_user.id).order(:nome_curto)
        @corps = Corp.where(user_id: current_user.id).order(:nome)
      end
  end
  
end
