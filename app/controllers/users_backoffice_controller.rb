class UsersBackofficeController < ApplicationController
    before_action :authenticate_user! # authenticate refere-se ao devise, user refere-se ao model sendo protegido
    before_action :build_perfil
    layout 'users_backoffice'
    
    private
    
    def build_perfil
       # Se não tiver perfil de usuário associado a instância, cria um perfil virtual.
        current_user.build_perfil_usuario if current_user.perfil_usuario.blank? 
    end
    
end
