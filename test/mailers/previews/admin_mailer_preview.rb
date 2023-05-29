class AdminMailerPreview < ActionMailer::Preview
  def alterou_email
    # Esse procedimento é apenas um teste, por isso pegou-se dois administradores aleatórios.
    AdminMailer.alterou_email(Admin.first, Admin.last)
  end
end
