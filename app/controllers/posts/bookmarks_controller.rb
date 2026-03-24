module Posts
  class BookmarksController < ApplicationController
    before_action :set_post

    def create
      @bookmark = @post.bookmarks.create!(name: @post.title)

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @post }
      end
    end

    def destroy
      @post.bookmarks.destroy_all

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @post }
      end
    end

    private

    def set_post
      @post = Post.find(params[:post_id])
    end
  end
end
