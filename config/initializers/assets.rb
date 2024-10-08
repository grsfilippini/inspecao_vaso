# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.

# app/assets
Rails.application.config.assets.precompile += %w( admins_backoffice.js admins_backoffice.css 
                                                  users_backoffice.js users_backoffice.css
                                                  admin_devise.js admin_devise.css
                                                  user_devise.js user_devise.css
                                                  site.js site.css
                                                  empresa_devise.js empresa_devise.css
                                                  empresas_backoffice.js empresas_backoffice.css
                                                  inspetor_devise.js inspetor_devise.css
                                                  inspetors_backoffice.js inspetors_backoffice.css)

# lib/assets/stylesheets e javascripts
Rails.application.config.assets.precompile += %w( sb-admin-2.js sb-admin-2.css 
                                                  custom.js 
                                                  custom.css 
                                                  img.jpg 
                                                  undraw_profile.svg
                                                  ticket.svg
                                                  logo_mantinsp.png
                                                  navbar.css)

# vendor/assets/stylesheets e javascripts
Rails.application.config.assets.precompile += %w( jquery-2.2.3/dist/jquery.min.js)

# Adicione seu arquivo pdf.scss à lista de ativos pré-compilados
Rails.application.config.assets.precompile += %w( pdf.scss )

                                                  