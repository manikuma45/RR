class Learning < ApplicationRecord
  before_validation :set_nameless_content

  validates :title, presence: true
  validates :title, length: { maximum: 1000 }
  validates :main_content, length: { maximum: 1000 }
  validates :sub_content, length: { maximum: 1000 }
  validates :url_info, length: { maximum: 1000 }
  # validates :image, length: { maximum: 1000 }

  attribute :checked_times, :integer, default: 0

  mount_uploader :image, ImageUploader

  belongs_to :user, optional: true
  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings

  def set_nameless_content
    self.main_content = '' if main_content.blank?
    self.sub_content = '' if sub_content.blank?
  end

end
