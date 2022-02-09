class ListsController < ApplicationController
  before_action :set_list, only: [:show, :destroy]

  def index
    @lists = current_user.lists.includes(:movies)
  end

  def show
    @bookmark = Bookmark.new
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.user = current_user
    if @list.save
      flash.notice = "Votre liste a été créée !"
      redirect_to list_path(@list)
    else
      flash.alert = "Erreur: votre liste ne peut être créée."
      render :new
    end
  end

  def destroy
    @list.destroy
    redirect_to lists_path
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
