class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [ :show, :edit_name, :update, :destroy ]

  def index
    @bookmarks = Bookmark.includes(:bookmarkable).order(:position)
  end

  def show
  end

  def edit_name
  end

  def update
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

  def destroy
    @bookmark.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@bookmark) }
      format.html { redirect_to bookmarks_path, notice: "Bookmark removed." }
    end
  end

  private

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end
end
