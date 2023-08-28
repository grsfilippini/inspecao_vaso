module UsersBackofficeHelper
  def avatar_user_url
    avatar = current_user.perfil_usuario.avatar
    avatar.attached? ? avatar : 'img.jpg'
  end
end
