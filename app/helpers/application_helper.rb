module ApplicationHelper    
  
  def radio_grupo(objeto, campo, opcoes, titulo, largura="300px", direcao=:horizontal)
    valor_atual = objeto.send(campo)
  
    fieldset_style = [
      "display:inline-block",
      "vertical-align:top",
      "width:#{largura}",
      "font-size:10pt",
      "border:1px solid #000",
      "padding:8px",
      "margin:0"
    ].join("; ")
  
    legend_style = "font-size:10pt; font-weight:bold; padding:0 6px;"
  
    itens_html = opcoes.map do |valor, texto|
      marcado = (valor_atual.to_s == valor.to_s)
  
      label_style =
        if direcao == :vertical
          "display:block; font-size:10pt; margin-bottom:4px;"
        else
          "display:inline-block; font-size:10pt; margin-right:12px;"
        end
  
      content_tag(:label, style: label_style) do
        radio_button_tag("#{objeto.class.model_name.param_key}[#{campo}]", valor, marcado) +
        " " +
        ERB::Util.html_escape(texto)
      end
    end.join.html_safe
  
    content_tag(:fieldset, style: fieldset_style) do
      content_tag(:legend, titulo, style: legend_style) + itens_html
    end
  end

  def checkbox_boolean_sequence(object:, fields:, direction: :vertical, width: "100%", item_width: nil)

    container_style = if direction == :horizontal
      "display:flex; flex-wrap:wrap; align-items:flex-start; gap:10px; width:#{width};"
    else
      "display:inline-block; width:#{width}; text-align:left;"
    end

    content_tag(:div, style: container_style) do

      safe_join(
        fields.map do |field, label|

          checked = object.send(field)

          item_style = if direction == :horizontal
            "display:inline-flex; align-items:flex-start; vertical-align:top; #{item_width ? "width:#{item_width};" : ""}"
          else
            "display:block; margin-bottom:3px;"
          end

          content_tag(:div, style: item_style) do

            checkbox = check_box_tag(
              field,
              "1",
              checked,
              disabled: true,
              style: "margin-right:5px; vertical-align:top;"
            )

            text = content_tag(:span, label)

            safe_join([checkbox, text])

          end

        end
      )

    end

  end

end
