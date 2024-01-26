class InspetorsBackofficeController < ApplicationController
    before_action :authenticate_inspetor!
    layout 'inspetors_backoffice'
end
