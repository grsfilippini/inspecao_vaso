module ApplicationHelper    
  
  def radio_grupo(objeto, campo, opcoes, titulo, largura="300px")
    html = "<fieldset style='border:1px solid #666; padding:8px; width:#{largura}; margin-top:8px; margin-bottom:8px;'>"
    html += "<legend><b>#{titulo}</b></legend>"
  
    opcoes.each do |valor, texto|
      checked = objeto.send(campo) == valor ? "checked" : ""
  
      html += "<label style='margin-right:18px;'>"
      html += "<input type='radio' name='relatorio[#{campo}]' value='#{valor}' #{checked}>"
      html += " #{texto}"
      html += "</label>"
    end
  
    html += "</fieldset>"
  
    html.html_safe
  end

end
