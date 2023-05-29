class ApplicationController < ActionController::Base
    
    layout :layout_by_resource
    before_action :set_global_params


    protected

    # Configurar o layout de acordo com o controler do devise que está sendo acessado: 
    #   Admin ou User
    def layout_by_resource
        if devise_controller? 
            "#{resource_class.to_s.downcase}_devise"        
        else
            "application"
        end
    end
    
    def set_global_params
        $global_params = params
    end
end
