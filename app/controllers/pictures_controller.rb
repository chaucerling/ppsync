class PicturesController < ApplicationController
  before_action :accessing, except: [:index, :new, :create]

  def index
    @pictures = Picture.where(user_id: current_user.id)
  end

  def new
    #@picture = Picture.new
    put_policy = Qiniu::Auth::PutPolicy.new("ppsync")
    put_policy.callback_url = "ppsync.herokuapp.com/qiniu/callback"
    put_policy.callback_body = "user_id=1"
    #put_policy.callback_body = "key=$(key)&origin=$(etag)&fsize=$(fsize)&imageInfo=$(imageInfo)&name=$(x:picname)&user_id=#{current_user.id}"
    @uptoken = Qiniu::Auth.generate_uptoken(put_policy)
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
    if @picture.destroy
      redirect_to pictures_path
    else
      redirect_to :back
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
    params.require(:picture).permit(:name, :origin, :origin_cache)
  end
end
