require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @post1 = Post.create!(title: "First Post", body: "Body one")
    @post2 = Post.create!(title: "Second Post", body: "Body two")
    @post3 = Post.create!(title: "Third Post", body: "Body three")
  end

  test "homepage renders bookmark list in position order" do
    b1 = @post1.bookmarks.create!
    b2 = @post2.bookmarks.create!

    get root_path
    assert_response :success

    assert_select ".bookmark-list li", minimum: 2
    assert response.body.index(@post1.title) < response.body.index(@post2.title)
  end

  test "homepage shows at most 10 bookmarks" do
    11.times do |i|
      post = Post.create!(title: "Post #{i}", body: "Body #{i}")
      post.bookmarks.create!
    end

    get root_path
    assert_response :success
    assert_select ".bookmark-list li", 10
  end

  test "homepage shows empty state when no bookmarks" do
    get root_path
    assert_response :success
    assert_select ".bookmark-list-empty"
  end

  test "homepage shows tombstone for bookmark with deleted post" do
    bookmark = @post1.bookmarks.create!
    @post1.delete # bypass dependent destroy

    get root_path
    assert_response :success
    assert_select ".bookmark-tombstone"
  end
end
