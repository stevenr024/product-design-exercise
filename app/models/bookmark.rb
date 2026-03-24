class Bookmark < ApplicationRecord
  belongs_to :bookmarkable, polymorphic: true
  positioned on: :bookmarkable

  validates :name, presence: true

  before_validation :set_default_name, on: :create
  before_create :set_position



  private

  def set_default_name
    self.name ||= bookmarkable.title if bookmarkable.respond_to?(:title)
  end

  def set_position
    self.position = Bookmark.maximum(:position).to_i + 1
  end
end
