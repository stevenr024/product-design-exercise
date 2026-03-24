class Post < ApplicationRecord
  has_many :bookmarks, as: :bookmarkable

  validates :title, presence: true, length: { maximum: 200 }
  validates :body, presence: true
end
