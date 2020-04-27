class Learning < ApplicationRecord
  before_validation :set_nameless_content

  validates :title, presence: true
  validates :title, length: { maximum: 1000 }
  validates :main_content, length: { maximum: 1000 }
  validates :sub_content, length: { maximum: 1000 }
  validates :url_info, length: { maximum: 1000 }
  # validates :image, length: { maximum: 1000 }

  attribute :checked_times, :integer, default: 0
  attribute :reappearance_date, :date, default: Date.today + 36500

  mount_uploader :image, ImageUploader

  belongs_to :user, optional: true
  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings

  # def self.ransackable_attributes(auth_object = nil)
  #   %w[title main_content sub_content created_on]
  # end

  def set_nameless_content
    self.main_content = '' if main_content.blank?
    self.sub_content = '' if sub_content.blank?
  end

end
