class Bookmark < ApplicationRecord
  belongs_to :bookmarkable, polymorphic: true
  positioned on: :bookmarkable

  validates :name, presence: true

  before_create :set_default_name

  private

  def set_default_name
    self.name ||= bookmarkable.title if bookmarkable.respond_to?(:title)
  end
end
