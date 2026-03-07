module AdminsBackoffice::RelatoriosHelper
  
  def cabecalho_relatorio(relatorio)
    html = ""
    html += "<table style='width:100%; border-collapse:collapse; margin-bottom:10px;'>"
    html += "  <tr>"
    html += "    <td style='border:1px solid #000; height:40px; text-align:center; vertical-align:middle; font-weight:bold; font-size:14pt;'>"
    html += "      N° Relatório <span style='color:#B22222;'>#{relatorio.id}</span>"
    html += "    </td>"
    html += "  </tr>"
    html += "</table>"
  
    html.html_safe
  end

end
