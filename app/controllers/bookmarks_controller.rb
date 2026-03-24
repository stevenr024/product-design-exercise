class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.includes(:bookmarkable).order(:position)
  end

  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to bookmarks_path, notice: "Bookmark removed."
  end
end
