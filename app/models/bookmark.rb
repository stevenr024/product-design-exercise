class Bookmark < ApplicationRecord
  belongs_to :bookmarkable, polymorphic: true
  positioned on: :bookmarkable

  validates :name, presence: true

  before_validation :set_default_name, on: :create

  private

  def set_default_name
    self.name ||= bookmarkable.title if bookmarkable.respond_to?(:title)
  end
end
