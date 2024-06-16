require 'find'
require 'fileutils'

class AdminsBackoffice::AdministraDocsController < AdminsBackofficeController
    include SharedMethods

    def administra
        pasta_empresa = File.join(Dir.pwd, 'public', gera_nome_pasta_principal(current_admin), 'pdfs')
        Dir.mkdir(pasta_empresa) unless Dir.exist?(pasta_empresa)
        @numero_arquivos_empresa = count_files_in_directory(pasta_empresa)
        pasta_equipamentos = File.join(Dir.pwd, 'public', gera_nome_pasta_principal(current_admin), 'equipamentos')
        Dir.mkdir(pasta_equipamentos) unless Dir.exist?(pasta_equipamentos)
        @numero_arquivos_equipamentos = count_files_in_directory(pasta_equipamentos)
        
    end

    def compactar
      # Realize os procedimentos de compactação aqui
  
      # Exemplo:
      sucesso = true
      pasta_principal = File.join(Dir.pwd, 'public', gera_nome_pasta_principal(current_admin))
      Dir.mkdir(pasta_principal) unless Dir.exist?(pasta_principal)
      
      # Arquivos da empresa
      empresa_path = File.join(pasta_principal, 'pdfs')
      Dir.mkdir(empresa_path) unless Dir.exist?(empresa_path)
      # seu código de compactação...
      input_folders = [empresa_path]
      # Nome do arquivo zip de saída
      output_file = File.join(pasta_principal, 'empresa.zip')
      # Chama o método para compactar
      zip_folders_and_files(input_folders, output_file)
  
      # Arquivos do equipamento
      equipamentos_path = File.join(pasta_principal, 'equipamentos')
      Dir.mkdir(equipamentos_path) unless Dir.exist?(equipamentos_path)
      # seu código de compactação...
      input_folders = [equipamentos_path]
      # Nome do arquivo zip de saída
      output_file = File.join(pasta_principal, 'equipamentos.zip')
      # Chama o método para compactar
      zip_folders_and_files(input_folders, output_file)
    end

    def apagar
      sucesso = true
      pasta_principal = File.join(Dir.pwd, 'public', gera_nome_pasta_principal(current_admin))
      empresa_path = File.join(pasta_principal, 'pdfs')
      equipamentos_path = File.join(pasta_principal, 'equipamentos')
      output_file_empresa = File.join(pasta_principal, 'empresa.zip')
      output_file_equipamentos = File.join(pasta_principal, 'equipamentos.zip')
    
      begin
        # Limpa o conteúdo das pastas
        FileUtils.rm_rf(Dir.glob(File.join(empresa_path, '*'))) if File.directory?(empresa_path)
        FileUtils.rm_rf(Dir.glob(File.join(equipamentos_path, '*'))) if File.directory?(equipamentos_path)
        
        # Exclui os arquivos
        File.delete(output_file_empresa) if File.exist?(output_file_empresa)
        File.delete(output_file_equipamentos) if File.exist?(output_file_equipamentos)
      rescue StandardError => e
        puts "Erro ao apagar pastas e arquivos: #{e.message}"
        sucesso = false
      end
    
      respond_to do |format|
        format.json { render json: { success: sucesso } }
      end
    end

end
