class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.includes(:bookmarkable).order(:position)
  end

  def edit_name
    @bookmark = Bookmark.find(params[:id])
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    name = params.dig(:bookmark, :name).presence || @bookmark.bookmarkable&.title || @bookmark.name

    respond_to do |format|
      if @bookmark.update(name: name)
        format.turbo_stream
        format.html { redirect_to bookmarks_path }
      else
        format.html { redirect_to bookmarks_path }
      end
    end
  end

  def reorder
    params[:ids].each_with_index do |id, index|
      Bookmark.where(id: id).update_all(position: index + 1)
    end
    head :ok
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
