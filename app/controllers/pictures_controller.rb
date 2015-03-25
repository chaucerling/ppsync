class PicturesController < ApplicationController
  before_action :accessing, only: [:show, :edit, :update, :destroy]

  def index
    @pictures = Picture.where(user_id: current_user.id)
  end

  def new
    @uptoken = QiniuPicture.uptoken current_user.id
    @picture = Picture.new
  end

  def show
    @picture = Picture.find(params[:id])
  end

  def edit
    @picture = Picture.find(params[:id])
  end

  def update
    @picture = Picture.find(params[:id])
    if @picture.update(picture_params)
      redirect_to @picture 
    else
      render :edit
    end
  end

  def destroy
    @picture = Picture.find(params[:id])
    if @picture.destroy
      redirect_to pictures_path
    else
      redirect_to :back
    end
  end

  def fetch  
    if Picture.fetch(params[:picture_url], current_user.id, picture_params[:name])
      redirect_to(@picture) 
    else 
      render :new
    end
  end

  protected
  def accessing
    if Picture.find(params[:id]).user_id != current_user.id
      redirect_to pictures_path
    end
  end

  private
  def picture_params
    params.require(:picture).permit(:name)
  end
end
