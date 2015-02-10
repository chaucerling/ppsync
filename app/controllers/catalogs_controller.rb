class CatalogsController < ApplicationController
  before_action :accessing, except: [:index, :new, :create]

  def index
    @catalogs = Catalog.where(user_id: current_user.id)
  end

  def new
    @catalog = Catalog.new
  end

  def create
    @catalog = Catalog.new(catalog_params)
    @catalog.user_id = current_user.id
    if @catalog.save
      p @catalog
      redirect_to @catalog
    else 
      render :new
    end
  end

  def show
    @catalog = Catalog.where(id: params[:id], user_id: current_user.id).take
  end

  def edit
    @catalog = Catalog.where(id: params[:id], user_id: current_user.id).take
  end

  def update
    @catalog = Catalog.where(id: params[:id], user_id: current_user.id).take
    if @catalog.update(picture_params)
      redirect_to @catalog 
    else
      render :edit
    end
  end

  def destroy
    if params[:id] !=1
      @catalog = Catalog.where(id: params[:id], user_id: current_user.id).take
      if @catalog.destroy
        redirect_to catalogs_path
      end
    end
    redirect_to :back
  end

  protected
  def accessing
    if Catalog.find(params[:id]).user_id != current_user.id
      redirect_to catalogs_path
    end
  end

  private
  def catalog_params
    params.require(:catalog).permit(:name)
  end
end
