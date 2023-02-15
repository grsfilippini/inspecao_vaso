module AdminsBackofficeHelper
    def traduz_atributos_humanos(objeto = nil, metodo = nil)
        if objeto && metodo
            objeto.model.human_attribute_name(metodo)
        else
            "Ao menos um parâmetro igual a nil"
        end
    end
end
