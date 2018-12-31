class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @article = Article.new
  end
  
  def edit
    #***en esta accion se crea una instance variable que recibe el parametro de id para encontrar el articulo que se quiere editar***
  end
  
  def create
    #render plain: params[:article].inspect ***Este codigo me permite ver en el navegador los parametros enviados por el form***
    #debugger
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      #***Esto ocurre cuando pasa las validaciones del model***
      flash[:success] = "Article was successfully created"
      redirect_to article_path(@article)
    else
      #***Cuando no pasa las validaciones del model***
      render 'new'
    end

  end
  
  def update
    #***En esta accion se crea nuevamente la instance variable que recibe el parametro de id y luego en un if statement
    #se le envia al metodo update los parametros del articulo que son titulo y descripcion
    if @article.update(article_params)
      #***Esto ocurre cuando pasa las validaciones del model***
      flash[:success] = "Article was successfully edited"
      redirect_to article_path(@article)
    else
      #***Cuando no pasa las validaciones del model***
      render 'edit'
    end
  end
  
  def show
  end
  
  def destroy
    @article.destroy
    flash[:danger] = "Article was successfully deleted"
    redirect_to articles_path
  end
  
  #***Funcion que usamos en las acciones de arriba para recibir los parametros de titulo y descripcion del form
  private
    
    def article_params
      params.require(:article).permit(:title, :description, category_ids: [])
    end
    
    def set_article
      @article = Article.find(params[:id])
    end
    
    def require_same_user
      if current_user != @article.user and !current_user.admin?
        flash[:danger] = "Stop right there buddy! You can only edit or delete your own stuff"
        redirect_to root_path
      end
    end
  
end