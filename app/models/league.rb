class League < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :user, presence: true

  belongs_to :user
  has_many :memberships, dependent: :destroy

  after_create :create_owner_admin

  def public!
    update(public_league: true)
  end

  private

  def create_owner_admin
    memberships.create!(user: user, role: 1)
  end
end
