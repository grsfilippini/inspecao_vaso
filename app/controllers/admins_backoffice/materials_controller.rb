class AdminsBackoffice::MaterialsController < AdminsBackofficeController
    before_action :set_material, only: [:edit, :update, :destroy]
    
    def index
      @materials = Material.all.order(:descricao).page(params[:page]).per(20)
    end
  
    def new
      @material = Material.new
    end
  
    def create
      @material = Material.new(params_material)
      if @material.save
        redirect_to admins_backoffice_materials_path, notice: "Material criado com sucesso!"    
      else
        render :new
      end
    end
  
  
    def edit # Ação de edição    
    end
  
    def update        
      if @material.update(params_material)
        redirect_to admins_backoffice_materials_path, notice: "Material atualizado com sucesso!"
      else
        render :edit
      end
    end
  
    def destroy
      if @material.destroy
        redirect_to admins_backoffice_materials_path, notice: "Material excluído com sucesso!"
      else
        render :index
      end
    end
  
 
    private
  
    
    def params_material
      puts params
      params.require(:material).permit(:id, :descricao)
    end
  
    def set_material
      # Resgata o registro passado em id, para dentro da variável admin
      @material = Material.find(params[:id])
    end
  
  end 
