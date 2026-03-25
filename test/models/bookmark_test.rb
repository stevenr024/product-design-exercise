require "test_helper"

class BookmarkTest < ActiveSupport::TestCase
  def setup
    @post = Post.create!(title: "Test Post", body: "Test body")
    @other_post = Post.create!(title: "Other Post", body: "Other body")
  end

  test "defaults name to post title on create" do
    bookmark = @post.bookmarks.create!
    assert_equal @post.title, bookmark.name
  end

  test "preserves explicit name if provided" do
    bookmark = @post.bookmarks.create!(name: "My custom name")
    assert_equal "My custom name", bookmark.name
  end

  test "is assigned a position on create" do
    bookmark = @post.bookmarks.create!
    assert_not_nil bookmark.position
  end

  test "new bookmark on a different post gets its own position" do
    first = @post.bookmarks.create!
    second = @other_post.bookmarks.create!
    assert_not_nil first.position
    assert_not_nil second.position
  end
end
