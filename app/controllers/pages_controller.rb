class PagesController < ApplicationController
  def home
    @total_posts = Post.count
    @recent_posts = Post.includes(:bookmarks).order(created_at: :desc).limit(3)
    @bookmarks = Bookmark.includes(:bookmarkable).order(:position).limit(10).select { |b| b.bookmarkable.present? }
  end
end
