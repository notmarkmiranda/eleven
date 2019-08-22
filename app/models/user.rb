class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  validates :email, uniqueness: {case_sensitive: false}, presence: true

  has_many :leagues
  has_many :memberships

  def all_leagues
    League.joins(:memberships).where("memberships.user_id = ?", id)
  end
end
