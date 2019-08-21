class League < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :user, presence: true

  belongs_to :user

  def public!
    update(public: true)
  end
end