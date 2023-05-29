module UsersBackoffice::PerfilHelper
  def selecao_sexo(user, sexo_atual)
    user.perfil_usuario.sexo == sexo_atual ? 'btn btn-primary' : 'btn-secondary'
  end
end
