class Post < ApplicationRecord
  has_many :bookmarks, as: :bookmarkable

  validates :title, presence: true
  validates :body, presence: true
end
