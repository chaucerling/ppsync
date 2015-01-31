class WebsitesController < ApplicationController
  before_action :accessing_catalog, only: [:index, :new, :create]
  before_action :accessing_website, only: [:show, :destroy]

  def index
    @catalog = Catalog.where(id: params[:catalog_id], user_id: current_user.id).take
    @websites = UserWebsite.where(user_id: current_user.id, catalog_id: params[:catalog_id])
  end

  def new
    @website = UserWebsite.new
  end

  def create
    @website = UserWebsite.new(website_params)
    @website.user_id = current_user.id
    @website.catalog_id = params[:catalog_id]
    if @website.save
      redirect_to website_path(@website[:id])
    else
      render :new
    end
  end

  def show
    @website = UserWebsite.where(id: params[:id], user_id: current_user.id).take
  end

  def destroy
    @website = UserWebsite.where(id: params[:id], user_id: current_user.id).take
    if @website.destroy
      redirect_to catalog_websites_path
    else 
      redirect_to :back
    end
  end

  protected
  def accessing_catalog
    if Catalog.find(params[:catalog_id]).user_id != current_user.id
      redirect_to catalogs_path
    end
  end

  def accessing_website
    if UserWebsite.find_by(id: params[:id]).user_id != current_user.id
      redirect_to catalog_websites_path
    end
  end

  private
  def website_params
    params.require(:user_website).permit(:catalog_id , :system_website_id)
  end
end
