class ArticlesController < ApplicationController
  
  def index
    @articles = Article.all
  end
  
  def new
    @article = Article.new
  end
  
  def edit
    #***en esta accion se crea una instance variable que recibe el parametro de id para encontrar el articulo que se quiere editar***
    @article = Article.find(params[:id])
  end
  
  def create
    #render plain: params[:article].inspect ***Este codigo me permite ver en el navegador los parametros enviados por el form***
    @article = Article.new(article_params)
    if @article.save
      #***Esto ocurre cuando pasa las validaciones del model***
      flash[:notice] = "Article was successfully created"
      redirect_to article_path(@article)
    else
      #***Cuando no pasa las validaciones del model***
      render 'new'
    end

  end
  
  def update
    #***En esta accion se crea nuevamente la instance variable que recibe el parametro de id y luego en un if statement
    #se le envia al metodo update los parametros del articulo que son titulo y descripcion
    @article = Article.find(params[:id])
    if @article.update(article_params)
      #***Esto ocurre cuando pasa las validaciones del model***
      flash[:notice] = "Article was successfully edited"
      redirect_to article_path(@article)
    else
      #***Cuando no pasa las validaciones del model***
      render 'edit'
    end
  end
  
  def show
    @article = Article.find(params[:id])
  end
  
  #***Funcion que usamos en las acciones de arriba para recibir los parametros de titulo y descripcion del form
  private
    def article_params
      params.require(:article).permit(:title, :description)
    end
  
end