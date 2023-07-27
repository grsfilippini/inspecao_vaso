namespace :dev do

  DEFAULT_PASSWORD = 123456
  DEFAULT_NOME     = '-'
  # Resgata o caminho da aplicação (Rails.root) e adiciona ao final o lib e o tmp
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      #show_spinner("Apagando BD...") { %x(rails db:drop) }
      #show_spinner("Criando BD...") { %x(rails db:create) }
      #show_spinner("Migrando BD...") { %x(rails db:migrate) }

      #show_spinner("Cadastrando  administrador padrão...")       { %x(rails dev:add_default_admin) }
      #show_spinner("Cadastrando exemplos de administradores...") { %x(rails dev:add_extras_admins) }
      #show_spinner("Cadastrando usuário padrão...")          { %x(rails dev:add_default_user) }
      show_spinner("Cadastrando empresa padrão...") { %x(rails dev:add_default_empresa) }
      
      #show_spinner("Cadastrando corporação padrão...")       { %x(rails dev:add_default_corp) }
      #show_spinner("Cadastrando região padrão...")           { %x(rails dev:add_default_regiao) }
      #show_spinner("Cadastrando estados padrões...")         { %x(rails dev:add_default_estados) }
      #show_spinner("Cadastrando cidades padrões...")         { %x(rails dev:add_default_cidades) }
      #show_spinner("Cadastrando exemplos de cadastros...")   { %x(rails dev:add_default_exemplos_cadastros) }
    else
      puts "Você não está em ambiente de desenvolvimento!"
    end
  end


  desc "Adiciona o administrador padrão"
  task add_default_admin: :environment do
    Admin.create!(
      email: 'admin@admin.com',
      nome: 'admin',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Adiciona administradores extras"
  task add_extras_admins: :environment do
    10.times do |i|
      Admin.create!(
        email: Faker::Internet.email,
        nome: Faker::Name.name,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
    end
  end


  desc "Adiciona o usuário padrão"
  task add_default_user: :environment do
    User.create!(
      email: 'user@user.com',
      nome: 'user',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end  

  desc "Adiciona o empresa padrão"
  task add_default_empresa: :environment do
    Empresa.create!(
      email: 'empresa@empresa.com', 
      nome: 'Empresa',
      corp_id: '0',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end  


  desc "Adiciona uma corporação padrão"
  task add_default_corp: :environment do
    Corp.create!(
      nome: DEFAULT_NOME      
    )
  end

  desc "Adiciona uma região padrão"
  task add_default_regiao: :environment do
    Regiao.create!(
      nome: DEFAULT_NOME,
      corp_id: 1
    )
  end
  
  # Lê listagem de estados do arquivo lib/tmp/estados.txt
  desc "Adiciona estados padrões"
  task add_default_estados: :environment do
    file_name = 'estados.txt'
    # Monta o nome do arquivo desde sua raiz (diretório) até seu nome final file_path
    file_path = File.join(DEFAULT_FILES_PATH, file_name)

    # Abre arquivo no modo leitura ('r') e lê linha a linha
    File.open(file_path, 'r').each do |line|
      sLine = line.strip # Limpa de caracteres ocultos (incluindo o espaço em branco) o início e final da linha lida
      arS = sLine.split(/\t/) # Retorna um array de elementos separados pelo tab (\t)
      id = arS[0]    # Atribui o elemento zero ao id
      nome = arS[1]  # Atribui o elemento zero ao nome
      uf = arS[2]    # Atribui o elemento zero a uf      
      Estado.create!(
        id: id,
        nome: nome,
        uf: uf 
      )
    end
  end

  # Lê listagem de cidades do arquivo lib/tmp/cidades.txt
  desc "Adiciona cidades padrões"
  task add_default_cidades: :environment do
    file_name = 'cidades.txt'
    # Monta o nome do arquivo desde sua raiz (diretório) até seu nome final file_path
    file_path = File.join(DEFAULT_FILES_PATH, file_name)

    # Abre arquivo no modo leitura ('r') e lê linha a linha
    File.open(file_path, 'r').each do |line|
      sLine = line.strip # Limpa de caracteres ocultos (incluindo o espaço em branco) o início e final da linha lida
      arS = sLine.split(/\t/) # Retorna um array de elementos separados pelo tab (\t)
      id = arS[0]    # Atribui o elemento zero ao id
      nome = arS[1]  # Atribui o elemento zero ao nome
      estado_id = arS[2]    # Atribui o elemento zero a uf      
      Cidade.create!(
        id: id,
        nome: nome,
        estado_id: estado_id
      )
    end
  end  
  
  # Lê listagem de cidades do arquivo lib/tmp/exemplo_cadastros.txt
  desc "Adiciona exemplos de cadastros"
  task add_default_exemplos_cadastros: :environment do
    file_name = 'exemplo_cadastros.txt'    
    file_path = File.join(DEFAULT_FILES_PATH, file_name)
    
      #File.open(file_path, 'r').each do |line|
       # sLine = line.strip
       # arS = sLine.split(/\t/)
       # id = arS[0]  
       # nome = arS[1]  # Atribui o elemento zero ao nome
       # estado_id = arS[2]    # Atribui o elemento zero a uf      
       # Cidade.create!(
       #   id: id,
       #   nome: nome,
       #   estado_id: estado_id
       # )
      #end
    
  end  


  private



  def show_spinner(msg_start, msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end

end