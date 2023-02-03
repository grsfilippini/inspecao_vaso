class UsersBackofficeController < ApplicationController
    before_action :authenticate_user! # authenticate refere-se ao devise, user refere-se ao model sendo protegido
    layout 'users_backoffice'
end
