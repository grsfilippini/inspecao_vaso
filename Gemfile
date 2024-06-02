source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.8', '>= 5.2.8.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
#gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

gem 'devise' # Usado para gerenciar usuários (incluindo admin, user, ...)
gem 'rails-i18n', '~> 5.1' # For 5.0.x, 5.1.x and 5.2.x, Trata da internacionalização de linguagem e outros aspectos regionais
gem 'tty-spinner' # Gem que tem o spinner (pequeno catavento) usado no console para funcionar como temporizador
gem 'faker' # Gem para inserir dados fakes no banco de dados teste
gem 'pry-rails', :group => :development # Gem para melhorar as saídas do ruby console
# Uso do pry-rails dentro do console rails, ex.: Admin.all
gem 'awesome_print' # Gem para melhorar as saídas do ruby console. Aplica cores, e orgniza informações
# Uso do awesome_print dentro do console rails, ex.: ap Admin.all

# kaminari é uma gem para paginação em páginas html muito extensas, ver uso no https://github.com/rails-camp/kaminari-gem-walkthrough tutorial completo ao final da página
# Para usar esta gem, deve-se ler a documentação, tem ajustes no controler, na view e no model (este último caso queira generalizar a paginação dentro do model)
# Pode-se ajustar a paginação diretamente no controler .per(5), ver a documentação.
gem 'kaminari'
gem 'kaminari-i18n', '~> 0.3.2' # Gem que ajusta o i18n para o kaminari em qualquer lingua

# Compressor de assets
gem 'terser'

# Gerador de pdf
gem 'wicked_pdf', '~> 2.7'
gem 'wkhtmltopdf-binary'

# Utiliza o timer cron do linux
# usado para definir tarefas de tempos em tempos
gem 'whenever', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]  
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Rails < 6
  #gem 'rails_db', '2.2.1'
  #gem 'capistrano', '~> 3.11', require: false
  gem 'capistrano', '~> 3.18.1', require: false
  gem 'capistrano-rvm'
  gem 'capistrano-bundler', '~> 1.5'
  gem 'capistrano-rails', '~> 1.4', require: false
  gem "capistrano3-unicorn"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Servidor de aplicação usado em production
group :production do
  gem 'unicorn'
  gem 'ed25519', '>= 1.2', '< 2.0'
  gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Última linha