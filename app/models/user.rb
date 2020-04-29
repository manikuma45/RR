# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  before_validation { email.downcase! }

  validates :name, presence: true
  validates :name, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true
  validates :email, length: { maximum: 255 }

  has_many :learnings, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
