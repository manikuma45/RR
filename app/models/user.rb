class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :learnings, dependent: :destroy

  # def password_required?
  #     if member?
  #       !persisted? || !password.nil? || !password_confirmation.nil?
  #     else
  #       false
  #     end
  #   end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
