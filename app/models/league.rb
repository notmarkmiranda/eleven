class League < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :user, presence: true

  belongs_to :user
  has_many :memberships, dependent: :destroy
  has_many :seasons, dependent: :destroy

  after_create :create_owner_admin
  after_create :create_inaugural_season

  def current_season
    seasons_in_order.find_by(active: true, completed: false)
  end

  def public!
    update(public_league: true)
  end

  def seasons_in_order
    seasons.order("created_at asc")
  end

  private

  def create_inaugural_season
    seasons.create!(completed: false, active: true)
  end

  def create_owner_admin
    memberships.create!(user: user, role: 1)
  end
end
