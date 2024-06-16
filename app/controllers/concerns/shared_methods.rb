require 'zip'

# app/controllers/concerns/shared_methods.rb
module SharedMethods
    extend ActiveSupport::Concern
  
    def gera_pdf_empresa_equipamento_assinado(admin, cadastro, vaso, template, nome_arquivo_assinado, layout, orientation)

      nome_arquivo_assinado = Time.now.strftime("%Y%m%d_%H%M%S_") + "mantinsp_" + nome_arquivo_assinado

      # Gera nome da pasta principal, exclusiva de cada administrador
      pasta_principal = gera_nome_pasta_principal(admin)

      # Verifica se não existe a pasta principal, então cria ela dentro de public
      principal_path = File.join(Dir.pwd, 'public', pasta_principal)
      Dir.mkdir(principal_path) unless Dir.exist?(principal_path)

      # Verifia se não tem a pasta de equipamentos, cria
      equipamentos_path = File.join(principal_path, 'equipamentos')
      Dir.mkdir(equipamentos_path) unless Dir.exist?(equipamentos_path)

      # Verifica se não tem a pasta pdf, cria
      pdfs_path = File.join(principal_path, 'pdfs')
      Dir.mkdir(pdfs_path) unless Dir.exist?(pdfs_path)
      
      # Verifica se não tem a pasta da corporação, cria
      corp = cadastro.corp.nome
      corp = corp.gsub(/[^a-zA-Z\s]/, "")
      corp = corp.gsub(/\s/, '_')
      pdfs_path = File.join(pdfs_path, corp)
      Dir.mkdir(pdfs_path) unless Dir.exist?(pdfs_path)

      # Verifica se não tem a pasta nome curto da empresa, cria
      nome_curto = cadastro.nome_curto
      nome_curto = nome_curto.gsub(/[^a-zA-Z\s]/, "")
      nome_curto = nome_curto.gsub(/\s/, '_')
      pdfs_path = File.join(pdfs_path, nome_curto)
      Dir.mkdir(pdfs_path) unless Dir.exist?(pdfs_path)

      # Se vier vaso diferente de nill, cria uma pasta com o num_serie do vaso
      unless vaso.nil?
        # Limpa o num_serie do vaso deixando apenas a-z, A-Z, '-' e 0-9
        num_serie = vaso.num_serie
        num_serie = num_serie.gsub(/[^a-zA-Z0-9\-.]/, "")
        # Para docs empresa
        pdfs_path = File.join(pdfs_path, num_serie)
        Dir.mkdir(pdfs_path) unless Dir.exist?(pdfs_path)
        # Para docs equipamentos
        equipamentos_path = File.join(equipamentos_path, num_serie)
        Dir.mkdir(equipamentos_path) unless Dir.exist?(equipamentos_path)
      end

      # Cria o arquivo pdf e armazena em pdf
      pdf_content = render_to_string(template: template, layout: layout)
      pdf = WickedPdf.new.pdf_from_string(
        pdf_content,
        encoding: 'UTF-8',
        layout: "pdf.html",
        orientation: orientation,
        page_size: "A4",
        margin: {top: 10, bottom: 10, left: 10, right: 10}
      )
      # Caminho para o arquivo que você deseja assinar
      path_doc_assinado_pdfs = Rails.root.join(pdfs_path, nome_arquivo_assinado)
      assina_arquivo_pdf(path_doc_assinado_pdfs, pdf)

      unless vaso.nil?
        path_doc_assinado_equipamentos = Rails.root.join(equipamentos_path, nome_arquivo_assinado)
        assina_arquivo_pdf(path_doc_assinado_equipamentos, pdf)
      end

      # Retorna o path do documento assinado
      path_doc_assinado_pdfs

    end
    
    # Assina um arquivo
    # O arquivo pfx contendo o certificado e a chave devem estar armazenados em "storage"
    # com o nome "pfx_file.pfx"
    # path_doc_assinado deve conter o caminho completo e o nome do documento a ser assinado
    #
    def assina_arquivo_pdf(path_doc_assinado, pdf)
      # ASSINAR ARQUIVO pdf
      # Caminho para o arquivo PFX
      pfx_path = File.join(Dir.pwd, 'storage', 'pfx_file.pfx')

      # Senha para o arquivo PFX
      pfx_password = '7428'

      # Ler o conteúdo do arquivo PFX
      pfx_data = File.read(pfx_path)

      # Carregar o arquivo PFX e extrair a chave privada e o certificado
      pfx = OpenSSL::PKCS12.new(pfx_data, pfx_password)
      private_key = pfx.key
      certificate = pfx.certificate

      # Transfere o conteúdo lido em pdf para um objeto PDF origami
      pdf_origami = Origami::PDF.read(StringIO.new(pdf))
    
      # Adiciona anotação de assinatura para ser visível no documento
      pagina = pdf_origami.get_page(1)
      #puts pdf_origami.pages.size
      sigannot = Annotation::Widget::Signature.new
      sigannot.Rect = Rectangle[:llx => 89.0, :lly => 386.0, :urx => 190.0, :ury => 353.0]
      pagina.add_annotation(sigannot)

      # Adiciona uma anotação qualquer
      text_annotation = Annotation::Text.new
      text_annotation.Rect = [1, 34, 102, 1]
      text_annotation.Contents = "Assinado Digitalmente\nVerifique em http://validar.iti.gov.br"
      pagina.add_annotation(text_annotation)
      
      # Assina o PDF com a chave especificada
      pdf_origami.sign(certificate, private_key, 
      :method => 'adbe.pkcs7.sha1',
      :annotation => sigannot, 
      :location => "Brasil", 
      :contact => "mantinsp@gmail.com", 
      :reason => "Autenticação de documento de engenharia"
      )
      
      # Extrai o conteúdo do pdf assinado (pdf_origami) e coloca em pdf_content
      pdf_content = pdf_origami.send(:output)

      # Salvar o PDF assinado, pdf_content no caminho path_doc_assinado
      # Faz isso no formato ASCII-8BIT
      File.open(path_doc_assinado, 'w:ASCII-8BIT') do |file|
        file << pdf_content
      end
    end

    # Gera o nome da pasta principal do admin
    def gera_nome_pasta_principal(admin)
      # Manter apenas letras e caracteres numéricos
      # este será o nome da pasta
      pasta_principal = admin.email
      pasta_principal = pasta_principal.gsub(/[^a-zA-Z0-9@.\-_]/, "")
      pasta_principal = pasta_principal.gsub(/[@]/, "-")
      pasta_principal = pasta_principal.gsub(/[.]/, "_")
    end
    
    # Conta os arquivos em uma pasta e suas sub-pastas
    def count_files_in_directory(directory)
      file_count = 0
    
      Find.find(directory) do |path|
        file_count += 1 if File.file?(path)
      end
    
      file_count
    end

    # Compacta arquivos da pasta input_folders e grava no arquivo output_file
    def zip_folders_and_files(input_folders, output_file)
      # puts "**********************"
      # puts output_file
      # puts input_folders
      # puts "**********************"
      File.delete(output_file) if File.exist?(output_file)
      Zip::File.open(output_file, Zip::File::CREATE) do |zipfile|
          input_folders.each do |folder|
            Dir[File.join(folder, '**', '**')].each do |file|
                zipfile.add(file.sub(folder + '/', ''), file)
            end
          end
      end
    end

  end