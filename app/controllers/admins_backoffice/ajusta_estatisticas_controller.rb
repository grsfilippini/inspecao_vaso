class AdminsBackoffice::AjustaEstatisticasController < AdminsBackofficeController

  def estatisticas
    
    @num_usuarios = User.count
    @num_cadastros = Cadastro.count
    @num_vasos = Vaso.count
    @num_dispsegs = DispSeguranca.count
    @num_relatorios = Relatorio.count
    @num_espessura_vasos = EspessuraVaso.count
    @num_rel_dispsegs = RelatorioDispseg.count
    
    # Atualiza valores na tabela de estatísticas
    AdminEstatistica.ajusta_total(AdminEstatistica::EVENTOS[:total_usuarios], @num_usuarios)
    AdminEstatistica.ajusta_total(AdminEstatistica::EVENTOS[:total_cadastros], @num_cadastros)
    AdminEstatistica.ajusta_total(AdminEstatistica::EVENTOS[:total_vasos], @num_vasos)
    AdminEstatistica.ajusta_total(AdminEstatistica::EVENTOS[:total_dispseg], @num_dispsegs)
    AdminEstatistica.ajusta_total(AdminEstatistica::EVENTOS[:total_relatorios], @num_relatorios)
    AdminEstatistica.ajusta_total(AdminEstatistica::EVENTOS[:total_espessura_vaso], @num_espessura_vasos)
    AdminEstatistica.ajusta_total(AdminEstatistica::EVENTOS[:total_rel_dispseg], @num_rel_dispsegs)            
  end
end
