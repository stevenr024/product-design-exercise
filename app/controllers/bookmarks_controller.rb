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

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@bookmark) }
      format.html { redirect_to bookmarks_path, notice: "Bookmark removed." }
    end
  end
end
