class BookmarksController < ApplicationController
  before_action :set_list, only: :create
  before_action :set_bookmark, only: [:edit, :update, :destroy]

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      flash.notice = "Film ajouté à #{@list.name}"
      redirect_to list_path(@list, anchor: "bookmark-#{@bookmark.id}")
    else
      flash.alert = "Erreur: impossible d'ajouter le film."
      redirect_to 'lists/show'
    end
  end

  def edit
  end

  def update
    @bookmark.update(bookmark_params)
    if @bookmark.save
      flash.notice = "Film modifié !"
      redirect_to list_path(@bookmark.list, anchor: "bookmark-#{@bookmark.id}")
    else
      flash.alert = "Erreur: modification annulée."
      render :new
    end
  end

  def destroy
    @bookmark.destroy
    redirect_to list_path(@bookmark.list)
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
