# frozen_string_literal: true

class Label < ApplicationRecord
  before_validation :set_nameless_label

  validates :label_name, presence: true
  belongs_to :learning, optional: true
  has_many :labelings, dependent: :destroy
  has_many :learnings, through: :labelings

  private

  def set_nameless_label
    self.label_name = '重要' if label_name.blank?
  end
end
