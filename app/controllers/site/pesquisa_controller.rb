class Site::PesquisaController < SiteController
  
  def vasos
    # O procedimento abaixo retorna o valor do parâmetro :termo enviado pelo navegador.
    # params[:termo]
    
    @vasos = Vaso.pesquisa(params[:page], params[:termo], current_user.id)        
    @count_vasos = Vaso.pesquisa_sem_pagina(params[:termo], current_user.id).count
    
    @fabricantes = Cadastro.where(eh_fabricante: true, eh_empresa_inspetora: false, user_id: current_user.id).order(:nome_curto)
    @proprietarias = Cadastro.where(eh_fabricante: false, eh_empresa_inspetora: false, user_id: current_user.id).order(:nome_curto)
    @corps = Corp.where(user_id: current_user.id).order(:nome)
  end
  
  def pesq_fab_prop
    if params[:fabricante_id].present?
      @vasos = Vaso.pesquisa_fabricante(params[:fabricante_id], params[:page], current_user.id)
      @count_vasos = Vaso.pesquisa_fabricante_sem_pagina(params[:fabricante_id], current_user.id).count
    elsif params[:proprietaria_id].present?
      @vasos = Vaso.pesquisa_proprietaria(params[:proprietaria_id], params[:page], current_user.id)
      @count_vasos = Vaso.pesquisa_proprietaria_sem_pagina(params[:proprietaria_id], current_user.id).count      
    elsif params[:corporacao_id].present?
      @vasos = Vaso.pesquisa_corporacao(params[:corporacao_id], params[:page], current_user.id)
      @count_vasos = Vaso.pesquisa_corporacao_sem_pagina(params[:corporacao_id], current_user.id).count      
    else      
      @vasos = Vaso.ultimos_vasos(params[:page], current_user.id)
      @count_vasos = Vaso.ultimos_vasos_sem_pagina(current_user.id).count
    end
    
    if params[:fabricante_id].present?
      @fab_atual = Cadastro.find(params[:fabricante_id])
    elsif params[:proprietaria_id].present?
      @prop_atual = Cadastro.find(params[:proprietaria_id])
    elsif params[:corporacao_id].present?
      @corp_atual = Corp.find(params[:corporacao_id])
    end
    
    @fabricantes = Cadastro.where(eh_fabricante: true, eh_empresa_inspetora: false, user_id: current_user.id).order(:nome_curto)
    @proprietarias = Cadastro.where(eh_fabricante: false, eh_empresa_inspetora: false, user_id: current_user.id).order(:nome_curto)
    @corps = Corp.where(user_id: current_user.id).order(:nome)
  end
 
end
