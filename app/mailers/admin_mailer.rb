class AdminMailer < ApplicationMailer
  
  def alterou_email(admin_atual, admin)
    @admin_atual = admin_atual
    @admin = admin
    
    mail(to: @admin.email, subject: "Seus dados foram alterados!")
    
  end
  
end
