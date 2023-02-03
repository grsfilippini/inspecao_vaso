class AdminsBackofficeController < ApplicationController
    before_action :authenticate_admin! # authenticate refere-se ao devise, admin refere-se ao model sendo protegido
    layout 'admins_backoffice'
end
