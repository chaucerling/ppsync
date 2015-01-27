class PicturesController < ApplicationController
  def index
    @pictures = Picture.where(user_id: current_user.id)
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new(picture_params)
    @picture.user_id=current_user.id
    @picture.save
    redirect_to @picture
  end

  def show
    @picture = Picture.where(id: params[:id], user_id: current_user.id).take
  end

  def edit
    @picture = Picture.where(id: params[:id], user_id: current_user.id).take
  end

  def update
    @picture = Picture.where(id: params[:id], user_id: current_user.id).take
    if @picture.update(picture_params)
      redirect_to @picture 
    else
      render :edit
    end
  end

  def destroy
    @picture = Picture.where(id: params[:id], user_id: current_user.id).take
    @picture.destroy
    redirect_to pictures_path
  end


  private
  def picture_params
    params.require(:picture).permit(:name, :origin, :origin_cache)
  end
end
