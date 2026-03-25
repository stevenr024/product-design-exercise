require "test_helper"

class BookmarksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @post1 = Post.create!(title: "First Post", body: "Body one")
    @post2 = Post.create!(title: "Second Post", body: "Body two")
    @post3 = Post.create!(title: "Third Post", body: "Body three")
    @bookmark1 = @post1.bookmarks.create!
    @bookmark2 = @post2.bookmarks.create!
    @bookmark3 = @post3.bookmarks.create!
  end

  test "index renders full bookmark list in position order" do
    get bookmarks_path
    assert_response :success
    assert_select ".bookmark-list li", 3
    assert response.body.index(@post1.title) < response.body.index(@post2.title)
  end

  test "destroy removes bookmark and responds with turbo stream" do
    delete bookmark_path(@bookmark1), headers: { "Accept" => "text/vnd.turbo-stream.html" }
    assert_response :success
    assert_select "turbo-stream[action='remove'][target='#{dom_id(@bookmark1)}']"
    assert_not Bookmark.exists?(@bookmark1.id)
  end

  test "reorder updates bookmark positions" do
    post reorder_bookmarks_path, params: {
      ids: [ @bookmark3.id, @bookmark1.id, @bookmark2.id ]
    }
    assert_response :success
    assert_equal 1, @bookmark3.reload.position
    assert_equal 2, @bookmark1.reload.position
    assert_equal 3, @bookmark2.reload.position
  end

  test "show renders tombstone page for bookmark with deleted post" do
    @post1.delete
    get bookmark_path(@bookmark1)
    assert_response :success
    assert_select "turbo-stream[action='remove'][target='#{dom_id(@bookmark1)}']", 0
  end

  test "update saves new name" do
    patch bookmark_path(@bookmark1), params: { bookmark: { name: "My custom name" } }
    assert_equal "My custom name", @bookmark1.reload.name
  end

  test "update falls back to post title if name is blank" do
    patch bookmark_path(@bookmark1), params: { bookmark: { name: "" } }
    assert_equal @post1.title, @bookmark1.reload.name
  end
end
